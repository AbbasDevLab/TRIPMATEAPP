import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final currentUserProvider = StreamProvider<UserModel?>((ref) async* {
  final authService = ref.watch(authServiceProvider);
  
  await for (final firebaseUser in authService.authStateChanges) {
    if (firebaseUser != null) {
      // TODO: Fetch user data from API
      // For now, return null
      yield null;
    } else {
      yield null;
    }
  }
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.currentFirebaseUser != null;
});

