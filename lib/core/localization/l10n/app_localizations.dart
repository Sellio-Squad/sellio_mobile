import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @top_stores.
  ///
  /// In en, this message translates to:
  /// **'Top Stores'**
  String get top_stores;

  /// No description provided for @trending_products.
  ///
  /// In en, this message translates to:
  /// **'Trending Products'**
  String get trending_products;

  /// No description provided for @search_results.
  ///
  /// In en, this message translates to:
  /// **'Search Results'**
  String get search_results;

  /// No description provided for @search_your_favorite_items.
  ///
  /// In en, this message translates to:
  /// **'Search your favorite items...'**
  String get search_your_favorite_items;

  /// No description provided for @special_offers.
  ///
  /// In en, this message translates to:
  /// **'Special Offers'**
  String get special_offers;

  /// No description provided for @add_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get add_to_cart;

  /// No description provided for @empty_cart_title.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty!'**
  String get empty_cart_title;

  /// No description provided for @empty_cart_desc.
  ///
  /// In en, this message translates to:
  /// **'Start exploring and purchasing your favorite items'**
  String get empty_cart_desc;

  /// No description provided for @empty_cart_button.
  ///
  /// In en, this message translates to:
  /// **'Start Exploring'**
  String get empty_cart_button;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @note_optional.
  ///
  /// In en, this message translates to:
  /// **'Note  (Optional)'**
  String get note_optional;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// No description provided for @drinks.
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get drinks;

  /// No description provided for @clothes.
  ///
  /// In en, this message translates to:
  /// **'Clothes'**
  String get clothes;

  /// No description provided for @thrift.
  ///
  /// In en, this message translates to:
  /// **'Thrift'**
  String get thrift;

  /// No description provided for @furniture.
  ///
  /// In en, this message translates to:
  /// **'furniture'**
  String get furniture;

  /// No description provided for @books.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get books;

  /// No description provided for @electronics.
  ///
  /// In en, this message translates to:
  /// **'Electronics'**
  String get electronics;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @account_screen.
  ///
  /// In en, this message translates to:
  /// **'Account Screen'**
  String get account_screen;

  /// No description provided for @no_products_available.
  ///
  /// In en, this message translates to:
  /// **'No products available'**
  String get no_products_available;

  /// No description provided for @featured_items.
  ///
  /// In en, this message translates to:
  /// **'Featured Items'**
  String get featured_items;

  /// No description provided for @has_been_placed_successfully.
  ///
  /// In en, this message translates to:
  /// **'has been placed successfully'**
  String get has_been_placed_successfully;

  /// No description provided for @has_been_delivered_successfully.
  ///
  /// In en, this message translates to:
  /// **'has been delivered successfully'**
  String get has_been_delivered_successfully;

  /// No description provided for @has_been_cancelled.
  ///
  /// In en, this message translates to:
  /// **'has been cancelled'**
  String get has_been_cancelled;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @our_friendly_team_is_here_to_help.
  ///
  /// In en, this message translates to:
  /// **'Our friendly team is here to help'**
  String get our_friendly_team_is_here_to_help;

  /// No description provided for @store_location.
  ///
  /// In en, this message translates to:
  /// **'store_location'**
  String get store_location;

  /// No description provided for @design_editor.
  ///
  /// In en, this message translates to:
  /// **'Design editor'**
  String get design_editor;

  /// No description provided for @s.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get s;

  /// No description provided for @m.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get m;

  /// No description provided for @l.
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get l;

  /// No description provided for @xl.
  ///
  /// In en, this message translates to:
  /// **'XL'**
  String get xl;

  /// No description provided for @two_xl.
  ///
  /// In en, this message translates to:
  /// **'2XL'**
  String get two_xl;

  /// No description provided for @three_xl.
  ///
  /// In en, this message translates to:
  /// **'3XL'**
  String get three_xl;

  /// No description provided for @accessories_and_gifts.
  ///
  /// In en, this message translates to:
  /// **'Accessories & Gifts'**
  String get accessories_and_gifts;

  /// No description provided for @home_and_decore.
  ///
  /// In en, this message translates to:
  /// **'Home & Decore'**
  String get home_and_decore;

  /// No description provided for @tech_accessories.
  ///
  /// In en, this message translates to:
  /// **'Tech Accessories'**
  String get tech_accessories;

  /// No description provided for @business_and_branding.
  ///
  /// In en, this message translates to:
  /// **'Business & Branding'**
  String get business_and_branding;

  /// No description provided for @customize_your_product.
  ///
  /// In en, this message translates to:
  /// **'Customize your product'**
  String get customize_your_product;

  /// No description provided for @choose_a_product_to_customize_it.
  ///
  /// In en, this message translates to:
  /// **'Choose_a_product_to_customize_it'**
  String get choose_a_product_to_customize_it;

  /// No description provided for @upload_logo_or_image.
  ///
  /// In en, this message translates to:
  /// **'Upload logo or image'**
  String get upload_logo_or_image;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get change_language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get delete_account;

  /// No description provided for @account_options.
  ///
  /// In en, this message translates to:
  /// **'account options'**
  String get account_options;

  /// No description provided for @are_you_sure_to_continue_deleting_account.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to continue deleting account?'**
  String get are_you_sure_to_continue_deleting_account;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @are_you_sure_to_continue_logout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to continue logout?'**
  String get are_you_sure_to_continue_logout;

  /// No description provided for @start_exploring_and_saving_your_favorite_items_here.
  ///
  /// In en, this message translates to:
  /// **'Start exploring and saving your favorite items here.'**
  String get start_exploring_and_saving_your_favorite_items_here;

  /// No description provided for @no_favourite_items.
  ///
  /// In en, this message translates to:
  /// **'No favourite items!'**
  String get no_favourite_items;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @stores.
  ///
  /// In en, this message translates to:
  /// **'Stores'**
  String get stores;

  /// No description provided for @recent_searches.
  ///
  /// In en, this message translates to:
  /// **'Recent Searches'**
  String get recent_searches;

  /// No description provided for @clear_all.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clear_all;

  /// No description provided for @no_results_found.
  ///
  /// In en, this message translates to:
  /// **'No results found!'**
  String get no_results_found;

  /// No description provided for @please_check_your_spelling_or_try_a_different_search.
  ///
  /// In en, this message translates to:
  /// **'Please check your spelling or try a different search.'**
  String get please_check_your_spelling_or_try_a_different_search;

  /// No description provided for @start_exploring_your_favorite_items.
  ///
  /// In en, this message translates to:
  /// **'Start exploring your favorite items!'**
  String get start_exploring_your_favorite_items;

  /// No description provided for @iraq.
  ///
  /// In en, this message translates to:
  /// **'Iraq'**
  String get iraq;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @view_details.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get view_details;

  /// No description provided for @cancel_order.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get cancel_order;

  /// No description provided for @placed_on.
  ///
  /// In en, this message translates to:
  /// **'Placed on'**
  String get placed_on;

  /// No description provided for @order_again.
  ///
  /// In en, this message translates to:
  /// **'Order again'**
  String get order_again;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get items;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get full_name;

  /// No description provided for @egypt.
  ///
  /// In en, this message translates to:
  /// **'Egypt'**
  String get egypt;

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
  /// **'Don\\\'t received code?'**
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

  /// No description provided for @enter_code.
  ///
  /// In en, this message translates to:
  /// **'Enter code'**
  String get enter_code;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forget_password;

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

  /// No description provided for @country_at_least_2_characters.
  ///
  /// In en, this message translates to:
  /// **'Country must be at least 2 characters'**
  String get country_at_least_2_characters;

  /// No description provided for @country_letters_only.
  ///
  /// In en, this message translates to:
  /// **'Country must contain only letters and spaces'**
  String get country_letters_only;

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

  /// No description provided for @failed_to_create_account.
  ///
  /// In en, this message translates to:
  /// **'Failed to create account. Please try again.'**
  String get failed_to_create_account;

  /// No description provided for @profile_photo_optional.
  ///
  /// In en, this message translates to:
  /// **'Profile photo (optional)'**
  String get profile_photo_optional;

  /// No description provided for @enter_the_4digit.
  ///
  /// In en, this message translates to:
  /// **'Please enter the 4-digit code sent to your phone number.'**
  String get enter_the_4digit;

  /// No description provided for @no_order_history.
  ///
  /// In en, this message translates to:
  /// **'No order history!'**
  String get no_order_history;

  /// No description provided for @start_exploring.
  ///
  /// In en, this message translates to:
  /// **'Start Exploring'**
  String get start_exploring;

  /// No description provided for @start_exploring_favorite_items.
  ///
  /// In en, this message translates to:
  /// **'Start exploring and purchasing your favorite items'**
  String get start_exploring_favorite_items;

  /// Total number of reviews for a store
  ///
  /// In en, this message translates to:
  /// **'(\$totalReviews reviews)'**
  String total_reviews(Object totalReviews);

  /// A message appears when no products match the search.
  ///
  /// In en, this message translates to:
  /// **'No product found for {search_query}'**
  String no_products_found_for(Object search_query);

  /// Message showing the order ID
  ///
  /// In en, this message translates to:
  /// **'Your order {orderId} from '**
  String your_order_from(Object orderId);

  /// Countdown timer for re-sending the confirmation code
  ///
  /// In en, this message translates to:
  /// **'Re-Send in \$resendCountdown Sec'**
  String re_send_in_resend_countdown_Sec(Object resendCountdown);

  /// Instruction to enter the 4-digit code sent to the user's phone number
  ///
  /// In en, this message translates to:
  /// **'Please enter the 4-digit code sent to \${phone_number}.'**
  String enter_the_4_digit_sent_to(Object phone_number);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
