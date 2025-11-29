import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/config/app_config.dart';
import 'core/config/theme/app_theme.dart';
import 'core/routes/app_router.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/locale_provider.dart';
import 'firebase_options.dart';

void main() async {
  // Wrap everything in try-catch to prevent crashes on startup
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Set preferred orientations first (lightweight)
    try {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } catch (e) {
      print('⚠️ Failed to set preferred orientations: $e');
    }

    // Set up error handling FIRST before anything else
    _setupErrorHandling();

    // Initialize Firebase asynchronously to avoid blocking main thread
    unawaited(_initializeFirebase());

    // Initialize Hive asynchronously
    unawaited(_initializeHive());

    // Run app - this should always succeed
    runApp(
      const ProviderScope(
        child: TripMateApp(),
      ),
    );
  } catch (e, stackTrace) {
    // If anything fails, show error and try to run app anyway
    print('❌ Critical error in main: $e');
    print('Stack trace: $stackTrace');
    
    // Try to run app anyway with error handling
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                    'App Initialization Error',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    e.toString(),
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Initialize Firebase in background
Future<void> _initializeFirebase() async {
  try {
    // Check if Firebase is configured (not using placeholder values)
    final options = DefaultFirebaseOptions.currentPlatform;
    if (options.apiKey != 'YOUR_ANDROID_API_KEY' && 
        options.projectId != 'YOUR_PROJECT_ID' &&
        options.apiKey.isNotEmpty &&
        options.projectId.isNotEmpty) {
      await Firebase.initializeApp(
        options: options,
      );
      print('✅ Firebase initialized successfully');
    } else {
      print('⚠️ Firebase not configured. Running in offline mode.');
    }
  } catch (e, stackTrace) {
    print('⚠️ Firebase initialization failed: $e');
    print('Stack trace: $stackTrace');
    print('⚠️ App will run without Firebase features.');
  }
}

// Initialize Hive in background
Future<void> _initializeHive() async {
  try {
    await Hive.initFlutter();
    print('✅ Hive initialized successfully');
  } catch (e, stackTrace) {
    print('⚠️ Hive initialization failed: $e');
    print('Stack trace: $stackTrace');
    print('⚠️ App will run without local storage features.');
  }
}

// Set up error handling
void _setupErrorHandling() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    print('❌ Flutter Error: ${details.exception}');
    if (details.stack != null) {
      print('Stack trace: ${details.stack}');
    }
  };
  
  // Handle platform errors (for physical devices)
  PlatformDispatcher.instance.onError = (error, stack) {
    print('❌ Platform Error: $error');
    if (stack != null) {
      print('Stack trace: $stack');
    }
    return true; // Error handled
  };

  // Set global error widget builder to prevent black screen
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text(
                'Something went wrong',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                details.exception.toString(),
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  };
}

class TripMateApp extends ConsumerWidget {
  const TripMateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: false,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Trip Mate',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          locale: locale,
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ur', 'PK'),
            Locale('pa', 'PK'),
          ],
          routerConfig: router,
          builder: (context, child) {
            if (child == null) return const SizedBox.shrink();
            
            // Prevent black screen by ensuring proper MediaQuery handling
            final mediaQuery = MediaQuery.of(context);
            return MediaQuery(
              data: mediaQuery.copyWith(
                // Preserve keyboard insets to prevent rendering issues
                viewInsets: mediaQuery.viewInsets,
                viewPadding: mediaQuery.viewPadding,
              ),
              child: child,
            );
          },
        );
      },
    );
  }
}

