import 'package:sellio_mobile/domain/entities/store.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/design_system/constants/app_strings.dart';

class ContactActionHandler {
  ContactActionHandler._();

  static Future<ContactActionResult> handleContact(ContactInfo contact) async {
    try {
      switch (contact.type) {
        case ContactType.email:
          return await _launchEmail(contact.provider);
        case ContactType.phone:
          return await _launchPhone(contact.provider);
        case ContactType.facebook:
          return await _launchFacebook(contact.provider);
        case ContactType.website:
          return await _launchUrl(contact.provider);
        case ContactType.whatsapp:
          return await _launchWhatsApp(contact.provider);
      }
    } catch (e) {
      return ContactActionResult.failure(_getErrorMessage(contact.type));
    }
  }

  static Future<ContactActionResult> _launchEmail(String email) async {
    final String encodedSubject = Uri.encodeComponent(AppStrings.emailSubject);
    final Uri emailUri = Uri.parse("mailto:$email?subject=$encodedSubject");

    try {
      final launched =
          await launchUrl(emailUri, mode: LaunchMode.externalApplication);
      return launched
          ? ContactActionResult.success()
          : ContactActionResult.failure(AppStrings.couldNotLaunchEmail);
    } catch (e) {
      return ContactActionResult.failure(AppStrings.couldNotLaunchEmail);
    }
  }

  static Future<ContactActionResult> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);

    try {
      if (await canLaunchUrl(phoneUri)) {
        final launched = await launchUrl(phoneUri);
        return launched
            ? ContactActionResult.success()
            : ContactActionResult.failure(AppStrings.couldNotLaunchPhone);
      }
      return ContactActionResult.failure(AppStrings.couldNotLaunchPhone);
    } catch (e) {
      return ContactActionResult.failure(AppStrings.couldNotLaunchPhone);
    }
  }

  static Future<ContactActionResult> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        final launched =
            await launchUrl(uri, mode: LaunchMode.externalApplication);
        return launched
            ? ContactActionResult.success()
            : ContactActionResult.failure(AppStrings.couldNotLaunchWebsite);
      }
      return ContactActionResult.failure(AppStrings.couldNotLaunchWebsite);
    } catch (e) {
      return ContactActionResult.failure(AppStrings.couldNotLaunchWebsite);
    }
  }

  static Future<ContactActionResult> _launchWhatsApp(String phone) async {
    final cleanPhone = phone.replaceAll(RegExp(r'\D'), '');
    final Uri whatsappUri = Uri.parse('https://wa.me/$cleanPhone');

    try {
      final launched =
          await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      return launched
          ? ContactActionResult.success()
          : ContactActionResult.failure(AppStrings.couldNotLaunchWhatsApp);
    } catch (e) {
      return ContactActionResult.failure(AppStrings.couldNotLaunchWhatsApp);
    }
  }

  static Future<ContactActionResult> _launchFacebook(String facebookUrl) async {
    String url = facebookUrl;

    if (!url.startsWith('http')) {
      url = 'https://www.facebook.com/$url';
    }

    final Uri uri = Uri.parse(url);

    try {
      final launched =
          await launchUrl(uri, mode: LaunchMode.externalApplication);
      return launched
          ? ContactActionResult.success()
          : ContactActionResult.failure(AppStrings.couldNotLaunchFacebook);
    } catch (e) {
      return ContactActionResult.failure(AppStrings.couldNotLaunchFacebook);
    }
  }

  static String _getErrorMessage(ContactType type) {
    switch (type) {
      case ContactType.email:
        return AppStrings.couldNotLaunchEmail;
      case ContactType.phone:
        return AppStrings.couldNotLaunchPhone;
      case ContactType.facebook:
        return AppStrings.couldNotLaunchFacebook;
      case ContactType.whatsapp:
        return AppStrings.couldNotLaunchWhatsApp;
      case ContactType.website:
        return AppStrings.couldNotLaunchWebsite;
    }
  }

  static String getContactTitle(ContactType type) {
    switch (type) {
      case ContactType.email:
        return AppStrings.emailTitle;
      case ContactType.phone:
        return AppStrings.phoneTitle;
      case ContactType.facebook:
        return AppStrings.facebookTitle;
      case ContactType.whatsapp:
        return AppStrings.whatsappTitle;
      case ContactType.website:
        return AppStrings.websiteTitle;
    }
  }
}

class ContactActionResult {
  final bool isSuccess;
  final String? errorMessage;

  const ContactActionResult._({
    required this.isSuccess,
    this.errorMessage,
  });

  factory ContactActionResult.success() =>
      const ContactActionResult._(isSuccess: true);

  factory ContactActionResult.failure(String message) => ContactActionResult._(
        isSuccess: false,
        errorMessage: message,
      );
}
