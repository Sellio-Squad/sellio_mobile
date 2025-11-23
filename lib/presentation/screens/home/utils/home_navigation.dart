import 'package:flutter/material.dart';
import '../../../../core/navigate/navigation_extensions.dart';
import '../../../../domain/entities/store.dart';
import '../../product_details/product_details_screen.dart';
import '../../store_details/store_details_screen.dart';

void navigateToStoreDetails(BuildContext context, Store store) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => StoreDetailsScreen(storeId: store.id),
    ),
  );
}

void navigateToProductDetails(BuildContext context, String productId) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(productId: productId)
    )
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