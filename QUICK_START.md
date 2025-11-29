# Trip Mate - Quick Start Guide

## 🚀 Getting Started in 5 Minutes

### 1. Install Dependencies
```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### 2. Configure Firebase
```bash
flutterfire configure
```
Or manually update `lib/firebase_options.dart`

### 3. Update Configuration
Edit `lib/core/config/app_config.dart`:
- Set your API base URL
- Add OpenAI API key
- Update Socket.IO URL

### 4. Run the App
```bash
flutter run
```

## 📱 Current Features

### ✅ Working Features
- Splash screen with auth check
- Onboarding flow
- User registration with FCCU email validation
- User login (Email/Password & Google)
- OTP verification
- Home screen with navigation
- Theme switching (Light/Dark)
- Multi-language support setup

### 🔧 Services Available
- `ApiService` - HTTP requests with token management
- `AuthService` - Authentication with Firebase
- `SocketService` - Real-time communication
- `AIService` - OpenAI integration
- `LocationService` - GPS and geocoding

## 🎨 UI Components

### Reusable Widgets
- `LoadingWidget` - Shimmer loading effect
- `CircularLoadingWidget` - Spinner with message
- `AppErrorWidget` - Error display with retry
- `EmptyStateWidget` - Empty state display

## 📂 Key Files

### Configuration
- `lib/core/config/app_config.dart` - App settings
- `lib/core/config/theme/app_theme.dart` - Theme configuration
- `lib/firebase_options.dart` - Firebase config

### Navigation
- `lib/core/routes/app_router.dart` - Route definitions

### State Management
- `lib/core/providers/theme_provider.dart` - Theme state
- `lib/core/providers/locale_provider.dart` - Language state

### Models
- `lib/core/models/user_model.dart` - User data model
- `lib/core/models/trip_model.dart` - Trip data model
- `lib/core/models/tour_model.dart` - Tour data model

## 🔑 API Endpoints Structure

All API calls go through `ApiService`:
```dart
final apiService = ApiService();

// GET request
final response = await apiService.get('/trips');

// POST request
final response = await apiService.post('/trips', data: tripData);
```

## 🎯 Common Tasks

### Add a New Page
1. Create page in `lib/features/[feature]/presentation/pages/`
2. Add route in `lib/core/routes/app_router.dart`
3. Navigate using `context.go('/route-name')`

### Add a New Service
1. Create service in `lib/core/services/`
2. Use `ApiService` for HTTP calls
3. Create provider in `lib/core/providers/` if needed

### Add a New Model
1. Create model in `lib/core/models/`
2. Add JSON serialization annotations
3. Run `flutter pub run build_runner build`

### Add a New Widget
1. Create widget in `lib/core/widgets/` (if reusable)
2. Or in feature-specific widget folder
3. Follow Material Design 3 guidelines

## 🐛 Troubleshooting

### Build Errors
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Firebase Issues
- Check `google-services.json` (Android) or `GoogleService-Info.plist` (iOS)
- Verify package name matches Firebase project
- Check Firebase console for enabled services

### API Errors
- Verify base URL in `app_config.dart`
- Check token is being set correctly
- Verify backend is running

## 📚 Useful Commands

```bash
# Format code
flutter format lib

# Analyze code
flutter analyze

# Run tests
flutter test

# Build APK
flutter build apk

# Build iOS
flutter build ios
```

## 🎨 Design Guidelines

- Use `ScreenUtil` for responsive sizing
- Follow Material Design 3
- Support both light and dark themes
- Use theme colors from `AppTheme`
- Add loading and error states

## 🔐 Security Notes

- Never commit API keys to git
- Use environment variables for sensitive data
- Validate all user inputs
- Use HTTPS for all API calls
- Implement proper error handling

## 📞 Need Help?

- Check `README.md` for detailed documentation
- See `SETUP.md` for setup instructions
- Review `PROJECT_STATUS.md` for progress

