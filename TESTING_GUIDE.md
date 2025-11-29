# Testing Guide - Trip Mate App

## 🧪 Test Mode Enabled

The app is currently in **Test Mode**, which allows you to test the authentication and profile features without needing a backend API.

## 📱 How to Sign In and Test Profile

### Option 1: Create a Test Account in Firebase Console

1. **Go to Firebase Console**: https://console.firebase.google.com
2. **Select your project** (or create one if needed)
3. **Navigate to Authentication** → **Users** tab
4. **Click "Add user"** button
5. **Enter test credentials**:
   - Email: `test@fccollege.edu.pk` or `test@formanite.fccollege.edu.pk` 
     - Teachers/Staff: `@fccollege.edu.pk`
     - Students: `@formanite.fccollege.edu.pk`
   - Password: `test123456` (minimum 6 characters)
6. **Click "Add user"**

### Option 2: Register a New Account in the App

1. **Open the app** on your emulator/device
2. **Tap "Sign Up"** on the login screen
3. **Fill in the registration form**:
   - Email: Must end with `@fccollege.edu.pk` (teachers/staff) or `@formanite.fccollege.edu.pk` (students)
     - Example: `teacher@fccollege.edu.pk` or `student@formanite.fccollege.edu.pk`
   - Password: At least 6 characters
   - First Name: Your first name
   - Last Name: Your last name
   - Phone: Optional
4. **Submit the form**

### Sign In Steps

1. **Open the app**
2. **On the login screen**, enter:
   - Email: `test@fccollege.edu.pk` or `test@formanite.fccollege.edu.pk` (or your registered email)
   - Password: `test123456` (or your password)
3. **Tap "Sign In"**
4. **You'll be redirected to the home page**

### Access Profile

1. **After signing in**, navigate to the profile page (usually from the bottom navigation or menu)
2. **You'll see**:
   - Your profile picture (or initials)
   - Your name and email
   - Profile menu options
   - Logout button

## ⚙️ Test Mode Configuration

Test mode is enabled in `lib/core/config/app_config.dart`:

```dart
static const bool testMode = true;
```

**What Test Mode Does:**
- ✅ Bypasses backend API calls for authentication
- ✅ Uses Firebase Authentication only
- ✅ Creates mock user data from Firebase user
- ✅ Allows testing UI without backend setup

**To Disable Test Mode:**
- Set `testMode = false` in `app_config.dart`
- Make sure your backend API is running and accessible

## 🔥 Firebase Setup (If Not Already Done)

If you haven't configured Firebase yet:

1. **Install FlutterFire CLI**:
   ```bash
   dart pub global activate flutterfire_cli
   ```

2. **Configure Firebase**:
   ```bash
   flutterfire configure
   ```

3. **Enable Authentication in Firebase Console**:
   - Go to Authentication → Sign-in method
   - Enable "Email/Password"
   - Enable "Google" (optional)

## 🚨 Important Notes

1. **Email Domain**: The app requires emails ending with `@fccollege.edu.pk`
2. **Password**: Minimum 6 characters
3. **Firebase Required**: You still need Firebase configured for authentication
4. **Backend API**: Not required in test mode, but will be needed for full functionality

## 🐛 Troubleshooting

### "Login failed" error
- Check if Firebase is properly configured
- Verify the email ends with `@fccollege.edu.pk`
- Make sure the user exists in Firebase Authentication

### "Please use your FCCU email address" error
- Your email must end with `@fccollege.edu.pk` (teachers/staff) or `@formanite.fccollege.edu.pk` (students)
- Check `AppConfig.fccuEmailDomains` in `app_config.dart`

### Profile not showing
- Make sure you're signed in (check Firebase Auth state)
- Navigate to `/profile` route
- Check if the profile page is accessible from navigation

## 📝 Test Credentials (Example)

You can use these test credentials if you create them in Firebase Console:

**For Teachers/Staff:**
- **Email**: `test@fccollege.edu.pk`
- **Password**: `test123456`

**For Students:**
- **Email**: `test@formanite.fccollege.edu.pk`
- **Password**: `test123456`

Or create your own with any email ending in `@fccollege.edu.pk` or `@formanite.fccollege.edu.pk`.

