// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'auth_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AuthLocalizationsEn extends AuthLocalizations {
  AuthLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title_login => 'Welcome Back!';

  @override
  String get subtitle_login => 'Enter your information to login';

  @override
  String get phone_number => 'Phone number';

  @override
  String get search_by_name_or_code => 'Search by name or code';

  @override
  String get login => 'Login';

  @override
  String get login_failed => 'Login failed. Please try again.';

  @override
  String get otp_verification_failed =>
      'OTP verification failed. Please try again.';

  @override
  String get resend_otp_failed => 'Failed to resend OTP. Please try again.';

  @override
  String get otp_resent_successfully => 'OTP has been resent successfully';

  @override
  String get password_min_6_characters =>
      'Password must be at least 6 characters';

  @override
  String get password_max_20_characters =>
      'Password must be less than 20 characters';

  @override
  String get passwords_do_not_match => 'Passwords do not match';

  @override
  String get title_forget_password => 'Forget your Password?';

  @override
  String get subtitle_forget_password =>
      'We will send 4-digit code to your below phone number.';

  @override
  String get send => 'send';

  @override
  String get set_new_password => 'Set new password';

  @override
  String get subtitle_set_new_password =>
      'Please enter your new password and make sure to remember it in next time';

  @override
  String get enter_your_information_to_create_account =>
      'Enter your information to create account';

  @override
  String get create_account => 'Create account';

  @override
  String get already_have_account => 'Already have account?';

  @override
  String get confirm_your_account => 'Confirm your account';

  @override
  String get confirm => 'Confirm';

  @override
  String get dont_received_code => 'Don\'t received code?';

  @override
  String get re_send => 'Re-Send';

  @override
  String get confirm_password => 'Confirm Password';

  @override
  String get password => 'Password';

  @override
  String get phone_number_must_be_at_least_10_digits =>
      'Phone number must be at least 10 digits';

  @override
  String get phone_number_digits_only =>
      'Phone number must contain only digits';

  @override
  String get full_name_at_least_2_characters =>
      'Full name must be at least 2 characters';

  @override
  String get full_name_letters_only =>
      'Full name must contain only letters and spaces';

  @override
  String get city_at_least_2_characters => 'City must be at least 2 characters';

  @override
  String get city_letters_only => 'City must contain only letters and spaces';

  @override
  String get failed_to_create_account =>
      'Failed to create account. Please try again.';

  @override
  String get account_created_successfully => 'Account created successfully';

  @override
  String get registration_failed => 'Registration failed';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get something_went_wrong => 'Something went wrong';

  @override
  String get profile_photo_optional => 'Profile photo (optional)';

  @override
  String get full_name => 'Full name';

  @override
  String get city => 'City';

  @override
  String re_send_in_resend_countdown_Sec(Object resendCountdown) {
    return 'Re-Send in $resendCountdown Sec';
  }

  @override
  String enter_the_4_digit_sent_to(Object phone_number) {
    return 'Please enter the 4-digit code sent to $phone_number.';
  }

  @override
  String get continue_text => 'Continue';
}
