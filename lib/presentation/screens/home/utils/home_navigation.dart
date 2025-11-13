import 'package:flutter/material.dart';
import '../../../../core/app_management/route/navigation_extensions.dart';
import '../../../../domain/entities/store.dart';
import '../../store_details/store_details_screen.dart';

void navigateToStoreDetails(BuildContext context, Store store) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => StoreDetailsScreen(
        storeId: store.id,
        coverImage: store.coverImage,
        profileImage: store.profileImage,
        storeName: store.name,
        rating: store.rating,
        discount: store.sale ?? '0',
      ),
    ),
  );
}

void navigateToNotifications(BuildContext context) {
  context.navigator.pushNotifications();
}

void navigateToFilterDialog(BuildContext context) {
  // TODO: Implement filter dialog
}

void navigateToOfferDetails(BuildContext context, String offerId) {
  // TODO: Implement offer details navigation
}