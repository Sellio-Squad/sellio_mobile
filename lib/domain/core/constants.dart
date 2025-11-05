class DomainConstants {
  DomainConstants._();

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Validation
  static const int minPasswordLength = 6;
  static const int otpLength = 4;
  static const int minNameLength = 2;
  static const int maxNameLength = 100;

  // Rating
  static const double minRating = 0.0;
  static const double maxRating = 5.0;

  // Cart
  static const int maxCartItems = 50;
  static const int minQuantity = 1;
  static const int maxQuantity = 99;

  // Search
  static const int minSearchQueryLength = 2;
  static const int searchDebounceMilliseconds = 500;

  // Cache duration
  static const Duration shortCacheDuration = Duration(minutes: 5);
  static const Duration mediumCacheDuration = Duration(minutes: 15);
  static const Duration longCacheDuration = Duration(hours: 1);

  // API Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration uploadTimeout = Duration(minutes: 2);

  // Error messages
  static const String networkErrorMessage = 'No internet connection';
  static const String serverErrorMessage = 'Server error occurred';
  static const String unknownErrorMessage = 'An unexpected error occurred';
}