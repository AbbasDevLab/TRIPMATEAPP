class AppConfig {
  // API Configuration
  static const String baseUrl = 'https://api.tripmate.fccu.edu.pk';
  static const String apiVersion = '/api/v1';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  // OpenAI Configuration
  static const String openAIApiKey = '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';
  static const String openAIModel = 'gpt-4';

  // Socket.IO Configuration
  static const String socketUrl = 'https://socket.tripmate.fccu.edu.pk';

  // Firebase Configuration
  static const bool enableFirebase = true;

  // App Information
  static const String appName = 'Trip Mate';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Travel companion for FCCU community';

  // FCCU Email Domains
  // Students use: formanite.fccollege.edu.pk
  // Teachers/Staff use: fccollege.edu.pk
  static const List<String> fccuEmailDomains = [
    '@formanite.fccollege.edu.pk',  // Student emails
    '@fccollege.edu.pk',              // Teacher/Staff emails
  ];

  // Feature Flags
  static const bool enable2FA = true;
  static const bool enableSOS = true;
  static const bool enableAI = true;
  static const bool enableChat = true;
  static const bool enableCommunity = true;
  
  // Test Mode - Set to true to bypass backend API for testing
  static const bool testMode = true;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Image Upload
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'webp'];

  // Cache Duration
  static const Duration cacheDuration = Duration(hours: 1);
  static const Duration tokenRefreshDuration = Duration(minutes: 15);

  // SOS Configuration
  static const Duration sosTimeout = Duration(minutes: 5);
  static const List<String> sosContacts = [];

  // Trip Categories
  static const List<String> tripCategories = [
    'Adventure',
    'Cultural',
    'Religious',
    'Educational',
    'Leisure',
    'Business',
    'Photography',
    'Food & Dining',
  ];

  // Trip Types
  static const List<String> tripTypes = [
    'Solo',
    'Group',
    'Family',
    'Business',
    'Educational',
    'Religious',
  ];

  // Languages
  static const List<Map<String, String>> supportedLanguages = [
    {'code': 'en', 'name': 'English', 'nativeName': 'English'},
    {'code': 'ur', 'name': 'Urdu', 'nativeName': 'اردو'},
    {'code': 'pa', 'name': 'Punjabi', 'nativeName': 'پنجابی'},
  ];
}

