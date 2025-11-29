import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../config/app_config.dart';
import '../models/user_model.dart';
import 'api_service.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ApiService _apiService = ApiService();

  // Check if email is FCCU email (student or teacher domain)
  bool isValidFCCUEmail(String email) {
    return AppConfig.fccuEmailDomains.any((domain) => email.endsWith(domain));
  }

  // Register with email and password
  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    if (!isValidFCCUEmail(email)) {
      throw Exception('Please use your FCCU email address');
    }

    // Create Firebase user
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Test mode: bypass backend API
    if (AppConfig.testMode) {
      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw Exception('Firebase registration failed');
      }
      
      // Create a mock user from Firebase user
      final user = UserModel(
        id: firebaseUser.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        profileImage: firebaseUser.photoURL,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      // Set mock tokens for test mode
      await _apiService.setToken('test_access_token', 'test_refresh_token');
      return user;
    }

    // Register with backend
    final response = await _apiService.post(
      '/auth/register',
      data: {
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'firebase_uid': userCredential.user?.uid,
      },
    );

    if (response.statusCode == 201) {
      final user = UserModel.fromJson(response.data['user']);
      await _apiService.setToken(
        response.data['access_token'],
        response.data['refresh_token'],
      );
      return user;
    } else {
      throw Exception('Registration failed');
    }
  }

  // Login with email and password
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    // Sign in with Firebase
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Test mode: bypass backend API
    if (AppConfig.testMode) {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        throw Exception('Firebase authentication failed');
      }
      
      // Create a mock user from Firebase user
      final user = UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? email,
        firstName: firebaseUser.displayName?.split(' ').first ?? 'Test',
        lastName: firebaseUser.displayName?.split(' ').last ?? 'User',
        phone: firebaseUser.phoneNumber,
        profileImage: firebaseUser.photoURL,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      // Set mock tokens for test mode
      await _apiService.setToken('test_access_token', 'test_refresh_token');
      return user;
    }

    // Login with backend
    final response = await _apiService.post(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final user = UserModel.fromJson(response.data['user']);
      await _apiService.setToken(
        response.data['access_token'],
        response.data['refresh_token'],
      );
      return user;
    } else {
      throw Exception('Login failed');
    }
  }

  // Google Sign In
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign in cancelled');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user?.email == null ||
          !isValidFCCUEmail(userCredential.user!.email!)) {
        await _firebaseAuth.signOut();
        await _googleSignIn.signOut();
        throw Exception('Please use your FCCU email address');
      }

      // Test mode: bypass backend API
      if (AppConfig.testMode) {
        final firebaseUser = userCredential.user;
        if (firebaseUser == null) {
          throw Exception('Firebase authentication failed');
        }
        
        // Create a mock user from Firebase user
        final nameParts = firebaseUser.displayName?.split(' ') ?? ['Test', 'User'];
        final user = UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          firstName: nameParts.first,
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : 'User',
          phone: firebaseUser.phoneNumber,
          profileImage: firebaseUser.photoURL,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        // Set mock tokens for test mode
        await _apiService.setToken('test_access_token', 'test_refresh_token');
        return user;
      }

      // Login with backend
      final response = await _apiService.post(
        '/auth/google',
        data: {
          'id_token': googleAuth.idToken,
          'access_token': googleAuth.accessToken,
        },
      );

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data['user']);
        await _apiService.setToken(
          response.data['access_token'],
          response.data['refresh_token'],
        );
        return user;
      } else {
        throw Exception('Google sign in failed');
      }
    } catch (e) {
      throw Exception('Google sign in error: $e');
    }
  }

  // Send OTP
  Future<void> sendOTP({
    required String email,
    String? phone,
    required String type,
  }) async {
    await _apiService.post(
      '/auth/send-otp',
      data: {
        'email': email,
        'phone': phone,
        'type': type,
      },
    );
  }

  // Verify OTP
  Future<bool> verifyOTP({
    required String email,
    String? phone,
    required String otp,
    required String type,
  }) async {
    final response = await _apiService.post(
      '/auth/verify-otp',
      data: {
        'email': email,
        'phone': phone,
        'otp': otp,
        'type': type,
      },
    );

    return response.statusCode == 200;
  }

  // Password Reset
  Future<void> resetPassword(String email) async {
    await _apiService.post(
      '/auth/password-reset',
      data: {'email': email},
    );
  }

  // Enable 2FA
  Future<Map<String, dynamic>> enable2FA() async {
    final response = await _apiService.post('/auth/2fa/enable');
    return response.data;
  }

  // Verify 2FA
  Future<bool> verify2FA(String code) async {
    final response = await _apiService.post(
      '/auth/2fa/verify',
      data: {'code': code},
    );
    return response.statusCode == 200;
  }

  // Logout
  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
    await _apiService.clearToken();
  }

  // Get current user
  User? get currentFirebaseUser => _firebaseAuth.currentUser;

  // Stream of auth state
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}

