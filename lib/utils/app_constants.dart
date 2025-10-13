class AppConstants {
  // App Information
  static const String appName = 'LooPay';
  static const String appVersion = '1.0.0';
  
  // API Endpoints (Placeholder)
  static const String baseUrl = 'https://api.loopay.com';
  static const String loginEndpoint = '/auth/login';
  static const String signupEndpoint = '/auth/signup';
  static const String transactionsEndpoint = '/transactions';
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 300);
  static const Duration mediumAnimation = Duration(milliseconds: 600);
  static const Duration longAnimation = Duration(milliseconds: 1000);
  
  // Validation Rules
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  
  // Currency
  static const String defaultCurrency = 'KES';
  static const String currencySymbol = 'KSh';
  
  // Transaction Types
  static const String transactionSent = 'sent';
  static const String transactionReceived = 'received';
  static const String transactionPending = 'pending';
  static const String transactionCompleted = 'completed';
  static const String transactionFailed = 'failed';
}
