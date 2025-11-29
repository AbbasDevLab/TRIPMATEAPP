# Firebase Setup Guide for Trip Mate

## ⚠️ Current Status: NOT CONFIGURED

Firebase Authentication is **NOT fully configured** yet. The `firebase_options.dart` file contains placeholder values that need to be replaced with real Firebase project credentials.

## 🚀 Quick Setup (Recommended)

### Step 1: Run FlutterFire CLI

Open your terminal in the project directory and run:

```bash
flutterfire configure
```

This will:
1. Ask you to log in to Firebase (opens browser)
2. Let you select or create a Firebase project
3. Automatically configure all platforms (Android, iOS, etc.)
4. Generate the `firebase_options.dart` file with real values
5. Download `google-services.json` for Android

### Step 2: Enable Authentication Methods

After running `flutterfire configure`, you need to enable authentication methods in Firebase Console:

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your project
3. Navigate to **Authentication** → **Sign-in method**
4. Enable the following:
   - ✅ **Email/Password** (click Enable)
   - ✅ **Google** (optional, for Google Sign-In)

### Step 3: Verify Configuration

Check that `lib/firebase_options.dart` has real values (not placeholders):
- ✅ `apiKey` should be a long string (not `YOUR_ANDROID_API_KEY`)
- ✅ `appId` should be like `1:123456789:android:abc123` (not `YOUR_ANDROID_APP_ID`)
- ✅ `projectId` should be your project name (not `YOUR_PROJECT_ID`)

## 📋 Manual Setup (Alternative)

If `flutterfire configure` doesn't work, you can set up manually:

### For Android:

1. **Create a Firebase Project**:
   - Go to [Firebase Console](https://console.firebase.google.com)
   - Click "Add project"
   - Enter project name: `TripMate` (or your choice)
   - Follow the setup wizard

2. **Add Android App**:
   - In Firebase Console, click the Android icon
   - Package name: `com.example.trip_mate` (from `android/app/build.gradle.kts`)
   - Download `google-services.json`
   - Place it in `android/app/google-services.json`

3. **Update build.gradle.kts**:
   Add the Google Services plugin to `android/app/build.gradle.kts`:
   ```kotlin
   plugins {
       id("com.android.application")
       id("kotlin-android")
       id("com.google.gms.google-services")  // Add this
       id("dev.flutter.flutter-gradle-plugin")
   }
   ```

4. **Update firebase_options.dart**:
   - Get your Firebase config from Firebase Console
   - Project Settings → Your apps → Android app
   - Copy the values and update `firebase_options.dart`

### For iOS (if needed):

1. **Add iOS App in Firebase Console**
2. **Download `GoogleService-Info.plist`**
3. **Add to Xcode project** (drag into `ios/Runner`)

## ✅ Verification Checklist

After setup, verify:

- [ ] `lib/firebase_options.dart` has real values (not placeholders)
- [ ] `android/app/google-services.json` exists (for Android)
- [ ] Email/Password authentication is enabled in Firebase Console
- [ ] App builds without Firebase errors
- [ ] You can create a test user in Firebase Console

## 🧪 Test After Setup

1. **Create a test user in Firebase Console**:
   - Authentication → Users → Add user
   - Email: `test@fccollege.edu.pk`
   - Password: `test123456`

2. **Run the app**:
   ```bash
   flutter run
   ```

3. **Try to sign in** with the test credentials

## 🔧 Troubleshooting

### Error: "DefaultFirebaseOptions have not been configured"
- Solution: Run `flutterfire configure` or manually update `firebase_options.dart`

### Error: "google-services.json not found"
- Solution: Download from Firebase Console and place in `android/app/`

### Error: "FirebaseApp not initialized"
- Solution: Make sure `Firebase.initializeApp()` is called in `main.dart` (it already is)

### Error: "Authentication method not enabled"
- Solution: Enable Email/Password in Firebase Console → Authentication → Sign-in method

## 📚 Additional Resources

- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com)
- [FlutterFire CLI Guide](https://firebase.flutter.dev/docs/cli/)

