# Trip Mate - Setup Guide

This guide will help you set up the Trip Mate application for development.

## Prerequisites

1. **Flutter SDK** (3.10 or higher)
   - Download from: https://flutter.dev/docs/get-started/install
   - Verify installation: `flutter doctor`

2. **Firebase Account**
   - Create a project at: https://console.firebase.google.com
   - Enable Authentication (Email/Password and Google Sign-In)

3. **MySQL Database**
   - Install MySQL Server
   - Create a database for the application

4. **OpenAI API Key**
   - Get your API key from: https://platform.openai.com/api-keys

5. **Development Tools**
   - Android Studio / VS Code
   - Git
   - Postman (for API testing)

## Step-by-Step Setup

### 1. Clone and Install Dependencies

```bash
# Navigate to project directory
cd TRIPMATEAPP

# Install Flutter dependencies
flutter pub get

# Generate required files
flutter pub run build_runner build --delete-conflicting-outputs
```

### 2. Firebase Configuration

#### Option A: Using FlutterFire CLI (Recommended)

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure

# Select your Firebase project and platforms (Android, iOS)
```

#### Option B: Manual Configuration

1. **Android Setup:**
   - Download `google-services.json` from Firebase Console
   - Place it in `android/app/`
   - Update `android/build.gradle` and `android/app/build.gradle`

2. **iOS Setup:**
   - Download `GoogleService-Info.plist` from Firebase Console
   - Place it in `ios/Runner/`
   - Update `ios/Runner/Info.plist`

3. **Update `lib/firebase_options.dart`:**
   - Replace placeholder values with your Firebase credentials

### 3. Backend API Configuration

1. **Update API Endpoints:**
   - Open `lib/core/config/app_config.dart`
   - Update `baseUrl` with your backend API URL
   - Update `socketUrl` with your Socket.IO server URL

2. **Set OpenAI API Key:**
   - In `lib/core/config/app_config.dart`
   - Replace `YOUR_OPENAI_API_KEY` with your actual API key

### 4. Database Setup

1. **Create MySQL Database:**
   ```sql
   CREATE DATABASE tripmate_db;
   ```

2. **Run Database Schema:**
   - Import the provided SQL schema file
   - Or create tables manually based on your requirements

3. **Update Database Connection:**
   - Configure your backend API to connect to MySQL
   - Update connection strings in your backend configuration

### 5. Environment Configuration

Create a `.env` file in the root directory (optional):

```env
FIREBASE_PROJECT_ID=your-project-id
OPENAI_API_KEY=your-openai-key
API_BASE_URL=https://api.tripmate.fccu.edu.pk
SOCKET_URL=https://socket.tripmate.fccu.edu.pk
```

### 6. Run the Application

```bash
# Check connected devices
flutter devices

# Run on Android
flutter run

# Run on iOS
flutter run -d ios

# Run in release mode
flutter run --release
```

## Platform-Specific Setup

### Android

1. **Update `android/app/build.gradle`:**
   - Set `minSdkVersion` to 21 or higher
   - Set `targetSdkVersion` to 33 or higher

2. **Update `android/app/src/main/AndroidManifest.xml`:**
   - Add internet permission
   - Add location permissions (if needed)

### iOS

1. **Update `ios/Podfile`:**
   - Set minimum iOS version to 12.0 or higher

2. **Update `ios/Runner/Info.plist`:**
   - Add location usage descriptions
   - Add camera and photo library permissions

3. **Install Pods:**
   ```bash
   cd ios
   pod install
   cd ..
   ```

## Troubleshooting

### Common Issues

1. **Build Runner Errors:**
   ```bash
   flutter clean
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

2. **Firebase Configuration Issues:**
   - Ensure `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) is in the correct location
   - Verify Firebase project settings match your app package name

3. **Dependency Conflicts:**
   ```bash
   flutter pub upgrade
   flutter pub get
   ```

4. **Generated Files Missing:**
   ```bash
   flutter pub run build_runner build
   ```

### Getting Help

- Check Flutter documentation: https://flutter.dev/docs
- Firebase documentation: https://firebase.google.com/docs
- Project README.md for feature documentation

## Next Steps

1. ✅ Complete Firebase setup
2. ✅ Configure backend API
3. ✅ Set up database
4. ✅ Add OpenAI API key
5. ✅ Test authentication flow
6. ✅ Test basic features
7. 🚀 Start development!

## Development Workflow

1. **Create a feature branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make changes and test:**
   ```bash
   flutter run
   ```

3. **Run tests:**
   ```bash
   flutter test
   ```

4. **Format code:**
   ```bash
   flutter format lib
   ```

5. **Analyze code:**
   ```bash
   flutter analyze
   ```

6. **Commit and push:**
   ```bash
   git add .
   git commit -m "Add your feature"
   git push origin feature/your-feature-name
   ```

## Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Firebase Documentation](https://firebase.google.com/docs)
- [OpenAI API Documentation](https://platform.openai.com/docs)

