import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sellio_mobile/domain/entities/store.dart';

class ContactActionHandler {
  ContactActionHandler._();

  static Future<ContactActionResult> handleContact(
      BuildContext context, ContactInfo contact) async {
    try {
      switch (contact.type) {
        case ContactType.email:
          return await _launchEmail(context, contact.provider);
        case ContactType.phone:
          return await _launchPhone(context, contact.provider);
        case ContactType.facebook:
          return await _launchFacebook(context, contact.provider);
        case ContactType.website:
          return await _launchUrl(context, contact.provider);
        case ContactType.whatsapp:
          return await _launchWhatsApp(context, contact.provider);
      }
    } catch (_) {
      return ContactActionResult.failure(
          _getErrorMessage(context, contact.type));
    }
  }

  static Future<ContactActionResult> _launchEmail(
      BuildContext context, String email) async {
    final encodedSubject = Uri.encodeComponent(context.local.email_subject);
    final Uri emailUri = Uri.parse("mailto:$email?subject=$encodedSubject");

    try {
      final launched =
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
      return launched
          ? ContactActionResult.success()
          : ContactActionResult.failure(context.local.could_not_launch_email);
    } catch (_) {
      return ContactActionResult.failure(context.local.could_not_launch_email);
    }
  }

  static Future<ContactActionResult> _launchPhone(
      BuildContext context, String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);

    try {
      if (await canLaunchUrl(phoneUri)) {
        final launched = await launchUrl(phoneUri);
        return launched
            ? ContactActionResult.success()
            : ContactActionResult.failure(context.local.could_not_launch_phone);
      }
      return ContactActionResult.failure(context.local.could_not_launch_phone);
    } catch (_) {
      return ContactActionResult.failure(context.local.could_not_launch_phone);
    }
  }

  static Future<ContactActionResult> _launchUrl(
      BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        final launched =
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return launched
            ? ContactActionResult.success()
            : ContactActionResult.failure(context.local.could_not_launch_website);
      }
      return ContactActionResult.failure(context.local.could_not_launch_website);
    } catch (_) {
      return ContactActionResult.failure(context.local.could_not_launch_website);
    }
  }

  static Future<ContactActionResult> _launchWhatsApp(
      BuildContext context, String phone) async {
    final cleanPhone = phone.replaceAll(RegExp(r'\D'), '');
    final Uri whatsappUri = Uri.parse('https://wa.me/$cleanPhone');

    try {
      final launched =
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      return launched
          ? ContactActionResult.success()
          : ContactActionResult.failure(context.local.could_not_launch_whatsapp);
    } catch (_) {
      return ContactActionResult.failure(context.local.could_not_launch_whatsapp);
    }
  }

  static Future<ContactActionResult> _launchFacebook(
      BuildContext context, String facebookUrl) async {
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
          : ContactActionResult.failure(context.local.could_not_launch_facebook);
    } catch (_) {
      return ContactActionResult.failure(context.local.could_not_launch_facebook);
    }
  }

  static String _getErrorMessage(BuildContext context, ContactType type) {
    switch (type) {
      case ContactType.email:
        return context.local.could_not_launch_email;
      case ContactType.phone:
        return context.local.could_not_launch_phone;
      case ContactType.facebook:
        return context.local.could_not_launch_facebook;
      case ContactType.whatsapp:
        return context.local.could_not_launch_whatsapp;
      case ContactType.website:
        return context.local.could_not_launch_website;
    }
  }

  static String getContactTitle(BuildContext context, ContactType type) {
    switch (type) {
      case ContactType.email:
        return context.local.email_title;
      case ContactType.phone:
        return context.local.phone_title;
      case ContactType.facebook:
        return context.local.facebook_title;
      case ContactType.whatsapp:
        return context.local.whatsapp_title;
      case ContactType.website:
        return context.local.website_title;
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
