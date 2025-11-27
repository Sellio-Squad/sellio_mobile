import 'package:flutter/material.dart';
import '../../../../core/navigate/navigation_extensions.dart';
import '../../../../core/navigate/route_args.dart';
import '../../../../domain/entities/store.dart';

void navigateToStoreDetails(BuildContext context, Store store) {
  context.navigator.pushStoreDetails(StoreDetailsArgs(storeId: store.id));

}

void navigateToProductDetails(BuildContext context, String productId) {
  context.navigator.pushProductDetails(ProductDetailsArgs(productId: productId));
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