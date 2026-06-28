// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'auth_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AuthLocalizationsAr extends AuthLocalizations {
  AuthLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get title_login => 'مرحباً بعودتك!';

  @override
  String get subtitle_login => 'أدخل معلوماتك لتسجيل الدخول';

  @override
  String get phone_number => 'رقم الهاتف';

  @override
  String get search_by_name_or_code => 'ابحث بواسطة الاسم أو الكود';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get login_failed => 'فشل تسجيل الدخول. يرجى المحاولة مرة أخرى.';

  @override
  String get otp_verification_failed =>
      'فشل التحقق من الرمز. يرجى المحاولة مرة أخرى.';

  @override
  String get resend_otp_failed =>
      'فشل إعادة إرسال الرمز. يرجى المحاولة مرة أخرى.';

  @override
  String get otp_resent_successfully => 'تم إعادة إرسال الرمز بنجاح';

  @override
  String get password_min_6_characters =>
      'يجب أن تكون كلمة المرور 6 أحرف على الأقل';

  @override
  String get password_max_20_characters =>
      'يجب أن تكون كلمة المرور أقل من 20 حرفًا';

  @override
  String get passwords_do_not_match => 'كلمتا المرور غير متطابقتين';

  @override
  String get title_forget_password => 'نسيت كلمة المرور؟';

  @override
  String get subtitle_forget_password =>
      'سنرسل رمز مكون من 4 أرقام إلى رقم هاتفك أدناه.';

  @override
  String get send => 'إرسال';

  @override
  String get set_new_password => 'تعيين كلمة مرور جديدة';

  @override
  String get subtitle_set_new_password =>
      'يرجى إدخال كلمة المرور الجديدة الخاصة بك والتأكد من تذكرها في المرة القادمة';

  @override
  String get enter_your_information_to_create_account =>
      'أدخل معلوماتك لإنشاء حساب';

  @override
  String get create_account => 'انشاء حساب';

  @override
  String get already_have_account => 'هل لديك حساب بالفعل؟';

  @override
  String get confirm_your_account => 'تأكيد حسابك';

  @override
  String get confirm => 'تأكيد';

  @override
  String get dont_received_code => 'لم تستلم الرمز؟';

  @override
  String get re_send => 'إعادة الإرسال';

  @override
  String get confirm_password => 'تأكيد كلمة المرور';

  @override
  String get password => 'كلمة المرور';

  @override
  String get phone_number_must_be_at_least_10_digits =>
      'يجب أن يكون رقم الهاتف 10 أرقام على الأقل';

  @override
  String get phone_number_digits_only =>
      'يجب أن يحتوي رقم الهاتف على أرقام فقط';

  @override
  String get full_name_at_least_2_characters =>
      'يجب أن يكون الاسم الكامل حرفين على الأقل';

  @override
  String get full_name_letters_only =>
      'يجب أن يحتوي الاسم الكامل على أحرف ومسافات فقط';

  @override
  String get city_at_least_2_characters =>
      'يجب أن يكون اسم المدينة حرفين على الأقل';

  @override
  String get city_letters_only =>
      'يجب أن يحتوي اسم المدينة على أحرف ومسافات فقط';

  @override
  String get failed_to_create_account =>
      'فشل إنشاء الحساب. يرجى المحاولة مرة أخرى.';

  @override
  String get account_created_successfully => 'تم انشاء الحساب بنجاح';

  @override
  String get registration_failed => 'فشل التسجيل';

  @override
  String get error => 'خطأ';

  @override
  String get success => 'تم بنجاح';

  @override
  String get something_went_wrong => 'حدث خطأ ما';

  @override
  String get profile_photo_optional => 'صورة الملف الشخصي (اختياري)';

  @override
  String get full_name => 'الاسم الكامل';

  @override
  String get city => 'المدينة';

  @override
  String re_send_in_resend_countdown_Sec(Object resendCountdown) {
    return 'إعادة الإرسال خلال \$resendCountdown ثانية';
  }

  @override
  String enter_the_4_digit_sent_to(Object phone_number) {
    return 'يرجى إدخال الرمز المكون من 4 أرقام المرسل إلى \$phone_number.';
  }

  @override
  String get continue_text => 'استمرار';
}
