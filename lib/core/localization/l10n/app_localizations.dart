// ignore_for_file: type=lint

abstract class AppLocalizations {
  final String locale;

  AppLocalizations(this.locale);

  // ===== Common =====
  String get guest;
  String get home;
  String get cart;
  String get login;
  String get logout;
  String get language;

  // ===== Errors =====
  String get should_not_be_empty;
  String get error_generic;

  // ===== Auth =====
  String get phone_number;
  String get password;
  String get forget_password;
  String get login_successful;
  String get login_failed;

  // ===== Dynamic strings =====
  String enter_the_4_digit_sent_to(Object phoneNumber);
  String total_reviews(Object totalReviews);
  String your_order_from(Object orderId);
}
