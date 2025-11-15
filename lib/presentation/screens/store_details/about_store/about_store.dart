import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/design_system/constants/app_icons.dart';
import '../../../../domain/entities/store.dart' as entity;
import '../../../../domain/repositories/store_repository.dart';
import 'cubit/AboutStoreCubit.dart';
import 'cubit/AboutStoreState.dart';
import 'models/ContactInfo.dart';
import 'widgets/address_item.dart';
import 'widgets/contact_info_item.dart';
import 'widgets/horizontal_driver.dart';
import 'widgets/rating_section.dart';

class AboutStore extends StatelessWidget {
  final String storeId;

  const AboutStore({
    super.key,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AboutStoreCubit(context.read<StoreRepository>())
        ..loadStoreInfo(storeId),
      child: Scaffold(
        appBar: const SellioAppBar(showBackButton: true, title: "About Store"),
        backgroundColor: context.theme.colors.surfaceLow,
        body: BlocBuilder<AboutStoreCubit, AboutStoreState>(
          builder: (context, state) {
            return _buildBody(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AboutStoreState state) {
    if (state is AboutStoreLoading || state is AboutStoreInitial) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is AboutStoreError) {
      return Center(
        child: Text(
          state.message,
          style: context.theme.typography.textTheme.bodyMedium.copyWith(
            color: context.theme.colors.hint,
          ),
        ),
      );
    }

    if (state is AboutStoreLoaded) {
      return _buildContent(context, state);
    }

    return const SizedBox.shrink();
  }

  Widget _buildContent(BuildContext context, AboutStoreLoaded state) {
    final store = state.store;
    final rating = state.rating;

    final contactInfoList = _buildContactInfoList(store);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingSection(
              averageRating: rating.averageRating,
              totalReviews: rating.totalReviews,
              ratingCounts: rating.ratingDistribution,
            ),
            const HorizontalDriver(),
            Text(
              "Contact Info",
              style: context.theme.typography.textTheme.titleMedium.copyWith(
                color: context.theme.colors.title,
              ),
            ),
            const SizedBox(height: 8),
            for (int i = 0; i < contactInfoList.length; i++) ...[
              ContactInfoItem(
                contactInfo: contactInfoList[i],
                onTap: () => _handleContactTap(contactInfoList[i]),
              ),
              if (i < contactInfoList.length - 1)
                const Padding(padding: EdgeInsets.only(bottom: 12)),
            ],
            const HorizontalDriver(),
            Text(
              "Address",
              style: context.theme.typography.textTheme.titleMedium.copyWith(
                color: context.theme.colors.title,
              ),
            ),
            AddressItem(address: store.address.fullAddress),
          ],
        ),
      ),
    );
  }

  List<ContactInfo> _buildContactInfoList(entity.Store store) {
    final List<ContactInfo> contactList = [];

    for (var storeContact in store.contactInfoList) {
      String icon;
      ContactType type;
      String title;

      switch (storeContact.type) {
        case entity.ContactType.email:
          icon = AppIcons.email;
          type = ContactType.email;
          title = "Our friendly team is here to help";
          break;
        case entity.ContactType.phone:
          icon = AppIcons.phone;
          type = ContactType.phone;
          title = "11:00 PM - 12:00 AM";
          break;
        case entity.ContactType.facebook:
          icon = AppIcons.facebook;
          type = ContactType.facebook;
          title = "Our account on facebook";
          break;
        case entity.ContactType.whatsapp:
          icon = AppIcons.phone;
          type = ContactType.whatsapp;
          title = "WhatsApp Contact";
          break;
        case entity.ContactType.website:
          icon = AppIcons.email;
          type = ContactType.website;
          title = "Visit our website";
          break;
      }

      contactList.add(
        ContactInfo(
          title: title,
          provider: storeContact.provider,
          icon: icon,
          type: type,
        ),
      );
    }

    return contactList;
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

  Future<void> _launchFacebook(String facebookUrl) async {
    String url = facebookUrl;

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
