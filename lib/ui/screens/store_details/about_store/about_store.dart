import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/design_system/constants/app_icons.dart';
import 'models/ContactInfo.dart';
import 'widgets/address_item.dart';
import 'widgets/contact_info_item.dart';
import 'widgets/horizontal_driver.dart';
import 'widgets/rating_section.dart';
import 'widgets/store_map_view.dart';

class AboutStore extends StatelessWidget {
  const AboutStore({super.key});

  static final List<ContactInfo> _contactInfoList = [
    ContactInfo(
      title: "Our friendly team is here to help",
      provider: "SweetLoversPasteleria2021@gmail.com",
      icon: AppIcons.email,
      type: ContactType.email,
    ),
    ContactInfo(
      title: "11:00 PM - 12:00 AM",
      provider: "+20 1026647377",
      icon: AppIcons.phone,
      type: ContactType.phone,
    ),
    ContactInfo(
      title: "Our account on facebook",
      provider: "https://www.facebook.com/share/1BpmS6Amet/",
      icon: AppIcons.facebook,
      type: ContactType.facebook,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SellioAppBar(showBack: true, title: "About Store"),
      backgroundColor: context.theme.colors.surfaceLow,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingSection(
                averageRating: 4.5,
                totalReviews: 250,
                ratingCounts: {5: 150, 4: 60, 3: 20, 2: 15, 1: 5},
              ),
              HorizontalDriver(),
              Text(
                "Contact Info",
                style: context.theme.typography.textTheme.titleMedium.copyWith(
                  color: context.theme.colors.title,
                ),
              ),
              const SizedBox(height: 8),
              for (int i = 0; i < _contactInfoList.length; i++) ...[
                ContactInfoItem(
                  contactInfo: _contactInfoList[i],
                  onTap: () => _handleContactTap(_contactInfoList[i]),
                ),
                if (i < _contactInfoList.length - 1)
                  Padding(padding: const EdgeInsets.only(bottom: 12)),
              ],
              HorizontalDriver(),
              Text(
                "Address",
                style: context.theme.typography.textTheme.titleMedium.copyWith(
                  color: context.theme.colors.title,
                ),
              ),
              AddressItem(address: "Karrada, Baghdad, Iraq"),
              StoreMapView(
                latitude: 30.0444,
                longitude: 31.2357,
                storeName: "Sellio store",
                onTap: () => _launchMap(30.0444, 31.2357, "Sellio store"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleContactTap(ContactInfo contact) async {
    switch (contact.type) {
      case ContactType.email:
        await _launchEmail(contact.provider);
        break;
      case ContactType.phone:
        await _launchPhone(contact.provider);
        break;
      case ContactType.facebook:
        await _launchFacebook(contact.provider);
        break;
      case ContactType.website:
        await _launchUrl(contact.provider);
        break;
      case ContactType.whatsapp:
        await _launchWhatsApp(contact.provider);
        break;
    }
  }

  Future<void> _launchEmail(String email) async {
    final String encodedSubject = Uri.encodeComponent("Sellio customer");
    final Uri emailUri = Uri.parse("mailto:$email?subject=$encodedSubject");

    try {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Could not launch email: $e');
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchWhatsApp(String phone) async {
    final cleanPhone = phone.replaceAll(RegExp(r'\D'), '');
    final Uri whatsappUri = Uri.parse('https://wa.me/$cleanPhone');
    try {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _launchMap(double lat, double lng, String storeName) async {
    final label = Uri.encodeComponent(storeName);
    final Uri mapUri = Uri.parse('geo:0,0?q=$lat,$lng($label)');
    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchFacebook(String facebookUrl) async {
    // Clean the URL if needed
    String url = facebookUrl;

    // If user provides just username/page ID, build the URL
    if (!url.startsWith('http')) {
      url = 'https://www.facebook.com/$url';
    }

    final Uri uri = Uri.parse(url);

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Could not launch Facebook: $e');
    }
  }
}

