import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/domain/entities/store.dart';
import 'package:sellio_mobile/domain/repositories/store_repository.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';
import 'cubit/about_store_cubit.dart';
import 'cubit/about_store_state.dart';
import 'helper/ContactActionHandler.dart';
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
        appBar: SellioAppBar(
          showBackButton: true,
          title: context.local.about_store,
        ),
        backgroundColor: context.theme.colors.surfaceLow,
        body: BlocConsumer<AboutStoreCubit, AboutStoreState>(
          listener: (context, state) {
            if (state is AboutStoreError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: context.theme.colors.hint,
                ),
              );
            }
          },
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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingHorizontal,
          vertical: LayoutConstants.paddingMedium,
        ),
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
              context.local.contact_info,
              style: context.theme.typography.textTheme.titleMedium.copyWith(
                color: context.theme.colors.title,
              ),
            ),
            const SizedBox(height: LayoutConstants.paddingSmall),
            ..._buildContactInfoList(context, store.contactInfoList),
            const HorizontalDriver(),
            Text(
              context.local.address,
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

  List<Widget> _buildContactInfoList(
    BuildContext context,
    List<ContactInfo> contactInfoList,
  ) {
    final widgets = <Widget>[];

    for (int i = 0; i < contactInfoList.length; i++) {
      final contact = contactInfoList[i];
      final iconAsset = _getContactIcon(contact.type);
      final title = ContactActionHandler.getContactTitle(context, contact.type);

      widgets.add(
        ContactInfoItem(
          icon: iconAsset,
          title: title,
          provider: contact.provider,
          onTap: () => _handleContactTap(context, contact),
        ),
      );

      if (i < contactInfoList.length - 1) {
        widgets.add(const SizedBox(height: LayoutConstants.itemSpacing));
      }
    }

    return widgets;
  }

  String _getContactIcon(ContactType type) {
    switch (type) {
      case ContactType.email:
        return AppImages.email;
      case ContactType.phone:
      case ContactType.whatsapp:
        return AppImages.phone;
      case ContactType.facebook:
        return AppImages.facebook;
      case ContactType.website:
        return AppImages.email;
    }
  }

  Future<void> _handleContactTap(
    BuildContext context,
    ContactInfo contact,
  ) async {
    final result = await ContactActionHandler.handleContact(context, contact);

    if (!result.isSuccess && result.errorMessage != null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.errorMessage!),
            backgroundColor: context.theme.colors.hint,
          ),
        );
      }
    }
  }
}
