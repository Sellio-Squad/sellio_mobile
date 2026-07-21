abstract class ValidationConstants {
  ValidationConstants._();

  static const int minNameLength = 2;
  static const int minLocationLength = 2;
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 20;
  static const int minPhoneLength = 10;
  
  static const int minStoreNameLength = 3;
  static const int maxStoreNameLength = 50;
  static const int minStoreDescriptionLength = 10;
  static const int maxStoreDescriptionLength = 500;

  static final RegExp digitsOnly = RegExp(r'^[0-9]+$');
  static final RegExp lettersAndSpaces = RegExp(r'^[a-zA-Z\u0600-\u06FF ]+$');
  static final RegExp namePattern = RegExp(r"^[a-zA-Z\u0600-\u06FF\s'-]+$");
}
