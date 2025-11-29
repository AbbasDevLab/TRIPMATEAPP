# Trip Mate - FCCU Travel Application

A comprehensive travel application designed exclusively for the Forman Christian College University (FCCU) community. Trip Mate provides AI-powered trip planning, group tour discovery, partner portal for guides and drivers, and community engagement features.

## ✨ Features

### 🔐 Authentication & Security
- Email/Phone Registration & Login with FCCU email validation
- Two-Factor Authentication (2FA) for enhanced security
- Google Sign-In integration
- Password Reset functionality
- OTP Verification for email and phone numbers
- SOS Emergency Feature with location sharing

### 🗺️ Trip Planning
- AI-Powered Itinerary Generation using OpenAI API
- Smart Budget Recommendations
- Hotel & Activity Suggestions
- Transportation Planning
- Multiple Trip Categories and Types

### 👥 Group Tours
- Tour Discovery with filtering and search
- Tour Booking System
- Guide & Driver Verification
- Tour Reviews & Ratings
- Real-time Availability
- Group Chat Integration

### 🏢 Partner Portal
- Guide Registration with verification
- Driver Registration with vehicle info
- Service Management
- Booking Management
- Earnings Tracking
- Analytics Dashboard

### 💬 Communication
- In-App Chat between users and partners
- Real-time Messaging with Socket.IO
- SOS Button in chat for emergencies
- File & Image Sharing
- Location Sharing

### 🌐 Community Features
- Community Feed for sharing experiences
- Post Creation with images and location
- Like, Comment, Share functionality
- User Profiles and connections
- Travel Stories and tips

### 🤖 AI Assistant
- Voice Search for hands-free interaction
- Image Search for visual queries
- Smart Recommendations based on preferences
- Chat-based Trip Planning
- Natural Language Processing

### 🌙 Modern UI/UX
- Dark/Light Theme support
- Multi-language Support (English, Urdu, Punjabi)
- Responsive Design with Flutter ScreenUtil
- Smooth Animations with Lottie
- Material Design 3 implementation

## 🛠️ Technology Stack

### Frontend
- **Flutter 3.10+** with Dart
- **Riverpod** for state management
- **GoRouter** for navigation
- **ScreenUtil** for responsive design
- **Material Design 3** for modern UI

### Backend Integration
- **Firebase Authentication** for user management
- **MySQL Database** with comprehensive schema
- **RESTful API** with Dio HTTP client
- **Socket.IO** for real-time communication
- **OpenAI API** for AI features

## 🚀 Getting Started

### Prerequisites
- Flutter 3.10+ installed
- Firebase project configured
- MySQL database set up
- OpenAI API key

### Installation

1. Clone the repository
   ```bash
   git clone <repository-url>
   cd TRIPMATEAPP
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Configure Firebase
   - Run `flutterfire configure` to set up Firebase
   - Or manually update `lib/firebase_options.dart` with your Firebase credentials

4. Set up MySQL database
   - Create database with provided schema
   - Update API endpoints in `lib/core/config/app_config.dart`

5. Configure OpenAI API
   - Add your OpenAI API key in `lib/core/config/app_config.dart`

6. Run the app
   ```bash
   flutter run
   ```

## 📱 App Structure

```
lib/
├── core/
│   ├── config/           # App configuration, themes, locales
│   ├── models/           # Data models with JSON serialization
│   ├── providers/        # Riverpod state management
│   ├── routes/           # Navigation configuration
│   ├── services/         # API and business logic
│   └── widgets/          # Reusable UI components
├── features/
│   ├── auth/             # Authentication pages
│   ├── home/             # Home screen and widgets
│   ├── trips/            # Trip planning features
│   ├── tours/            # Group tours functionality
│   ├── community/        # Social features
│   ├── chat/             # Messaging system
│   ├── profile/          # User profile management
│   ├── partner/          # Partner portal
│   ├── ai/               # AI assistant features
│   ├── sos/              # Emergency features
│   └── onboarding/       # App introduction
└── main.dart             # App entry point
```

## 🔒 Security Features

- Data Encryption in transit and at rest
- Two-Factor Authentication with TOTP
- Session Management with automatic timeout
- Input Validation and sanitization
- Rate Limiting for API calls
- Emergency SOS with location tracking
- Privacy Controls for user data

## 🌐 Localization

- English (default)
- اردو (Urdu)
- پنجابی (Punjabi)
- Extensible for additional languages
- RTL Support for Urdu and Punjabi

## 📊 Performance Optimizations

- Image Caching with cached_network_image
- Lazy Loading for large lists
- Offline Mode with local storage
- Database Indexing for fast queries
- API Response Caching
- Shimmer Loading states

## 🔮 Future Enhancements

- Payment Gateway integration
- AR Travel Previews
- Expansion to other universities
- Advanced AI Features
- Offline Maps support
- Push Notifications system

## 📄 License

This project is developed exclusively for the FCCU community and is not for commercial distribution.

## 👥 Team

Developed by Haider Abbas and Taha Khurram for the FCCU Community Travel App project.

## 📝 Notes

- Make sure to run `flutter pub run build_runner build` to generate required files after cloning
- Update all API endpoints and keys before running the app
- Configure Firebase properly for authentication to work
- Set up MySQL database schema before using backend features

