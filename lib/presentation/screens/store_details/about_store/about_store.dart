import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:sellio_mobile/domain/entities/store.dart' as entity;
import 'package:sellio_mobile/domain/repositories/store_repository.dart';
import '../../../../core/design_system/constants/app_icons.dart';
import '../../../../core/design_system/constants/app_strings.dart';
import '../../../../core/design_system/constants/layout_constants.dart';
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
        appBar: const SellioAppBar(
          showBackButton: true,
          title: AppStrings.aboutStore,
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
              AppStrings.contactInfo,
              style: context.theme.typography.textTheme.titleMedium.copyWith(
                color: context.theme.colors.title,
              ),
            ),
            const SizedBox(height: LayoutConstants.paddingSmall),
            ..._buildContactInfoList(context, store.contactInfoList),
            const HorizontalDriver(),
            Text(
              AppStrings.address,
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
    List<entity.ContactInfo> contactInfoList,
  ) {
    final widgets = <Widget>[];

    for (int i = 0; i < contactInfoList.length; i++) {
      final contact = contactInfoList[i];
      final iconAsset = _getContactIcon(contact.type);
      final title = ContactActionHandler.getContactTitle(contact.type);

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

  String _getContactIcon(entity.ContactType type) {
    switch (type) {
      case entity.ContactType.email:
        return AppIcons.email;
      case entity.ContactType.phone:
      case entity.ContactType.whatsapp:
        return AppIcons.phone;
      case entity.ContactType.facebook:
        return AppIcons.facebook;
      case entity.ContactType.website:
        return AppIcons.email; // Replace with website icon if available
    }
  }

  Future<void> _handleContactTap(
    BuildContext context,
    entity.ContactInfo contact,
  ) async {
    final result = await ContactActionHandler.handleContact(contact);

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
