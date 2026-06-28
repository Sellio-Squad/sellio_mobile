import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'auth_localizations_ar.dart';
import 'auth_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AuthLocalizations
/// returned by `AuthLocalizations.of(context)`.
///
/// Applications need to include `AuthLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/auth_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AuthLocalizations.localizationsDelegates,
///   supportedLocales: AuthLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AuthLocalizations.supportedLocales
/// property.
abstract class AuthLocalizations {
  AuthLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AuthLocalizations of(BuildContext context) {
    return Localizations.of<AuthLocalizations>(context, AuthLocalizations)!;
  }

  static const LocalizationsDelegate<AuthLocalizations> delegate =
      _AuthLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @title_login.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get title_login;

  /// No description provided for @subtitle_login.
  ///
  /// In en, this message translates to:
  /// **'Enter your information to login'**
  String get subtitle_login;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone_number;

  /// No description provided for @search_by_name_or_code.
  ///
  /// In en, this message translates to:
  /// **'Search by name or code'**
  String get search_by_name_or_code;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @login_failed.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please try again.'**
  String get login_failed;

  /// No description provided for @otp_verification_failed.
  ///
  /// In en, this message translates to:
  /// **'OTP verification failed. Please try again.'**
  String get otp_verification_failed;

  /// No description provided for @resend_otp_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to resend OTP. Please try again.'**
  String get resend_otp_failed;

  /// No description provided for @otp_resent_successfully.
  ///
  /// In en, this message translates to:
  /// **'OTP has been resent successfully'**
  String get otp_resent_successfully;

  /// No description provided for @password_min_6_characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get password_min_6_characters;

  /// No description provided for @password_max_20_characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be less than 20 characters'**
  String get password_max_20_characters;

  /// No description provided for @passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwords_do_not_match;

  /// No description provided for @title_forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget your Password?'**
  String get title_forget_password;

  /// No description provided for @subtitle_forget_password.
  ///
  /// In en, this message translates to:
  /// **'We will send 4-digit code to your below phone number.'**
  String get subtitle_forget_password;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'send'**
  String get send;

  /// No description provided for @set_new_password.
  ///
  /// In en, this message translates to:
  /// **'Set new password'**
  String get set_new_password;

  /// No description provided for @subtitle_set_new_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your new password and make sure to remember it in next time'**
  String get subtitle_set_new_password;

  /// No description provided for @enter_your_information_to_create_account.
  ///
  /// In en, this message translates to:
  /// **'Enter your information to create account'**
  String get enter_your_information_to_create_account;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get create_account;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have account?'**
  String get already_have_account;

  /// No description provided for @confirm_your_account.
  ///
  /// In en, this message translates to:
  /// **'Confirm your account'**
  String get confirm_your_account;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @dont_received_code.
  ///
  /// In en, this message translates to:
  /// **'Don\'t received code?'**
  String get dont_received_code;

  /// No description provided for @re_send.
  ///
  /// In en, this message translates to:
  /// **'Re-Send'**
  String get re_send;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @phone_number_must_be_at_least_10_digits.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be at least 10 digits'**
  String get phone_number_must_be_at_least_10_digits;

  /// No description provided for @phone_number_digits_only.
  ///
  /// In en, this message translates to:
  /// **'Phone number must contain only digits'**
  String get phone_number_digits_only;

  /// No description provided for @full_name_at_least_2_characters.
  ///
  /// In en, this message translates to:
  /// **'Full name must be at least 2 characters'**
  String get full_name_at_least_2_characters;

  /// No description provided for @full_name_letters_only.
  ///
  /// In en, this message translates to:
  /// **'Full name must contain only letters and spaces'**
  String get full_name_letters_only;

  /// No description provided for @city_at_least_2_characters.
  ///
  /// In en, this message translates to:
  /// **'City must be at least 2 characters'**
  String get city_at_least_2_characters;

  /// No description provided for @city_letters_only.
  ///
  /// In en, this message translates to:
  /// **'City must contain only letters and spaces'**
  String get city_letters_only;

  /// No description provided for @failed_to_create_account.
  ///
  /// In en, this message translates to:
  /// **'Failed to create account. Please try again.'**
  String get failed_to_create_account;

  /// No description provided for @account_created_successfully.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully'**
  String get account_created_successfully;

  /// No description provided for @registration_failed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registration_failed;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get something_went_wrong;

  /// No description provided for @profile_photo_optional.
  ///
  /// In en, this message translates to:
  /// **'Profile photo (optional)'**
  String get profile_photo_optional;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get full_name;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// Countdown timer for re-sending the confirmation code
  ///
  /// In en, this message translates to:
  /// **'Re-Send in {resendCountdown} Sec'**
  String re_send_in_resend_countdown_Sec(Object resendCountdown);

  /// Instruction to enter the 4-digit code sent to the user's phone number
  ///
  /// In en, this message translates to:
  /// **'Please enter the 4-digit code sent to {phone_number}.'**
  String enter_the_4_digit_sent_to(Object phone_number);

  /// No description provided for @continue_text.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_text;
}

class _AuthLocalizationsDelegate
    extends LocalizationsDelegate<AuthLocalizations> {
  const _AuthLocalizationsDelegate();

  @override
  Future<AuthLocalizations> load(Locale locale) {
    return SynchronousFuture<AuthLocalizations>(
        lookupAuthLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AuthLocalizationsDelegate old) => false;
}

AuthLocalizations lookupAuthLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AuthLocalizationsAr();
    case 'en':
      return AuthLocalizationsEn();
  }

  throw FlutterError(
      'AuthLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
