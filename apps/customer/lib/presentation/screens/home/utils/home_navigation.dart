import 'package:flutter/material.dart';

import '../../../../core/navigate/navigation_extensions.dart';
import '../../../../core/navigate/route_args.dart';

void navigateToStoreDetails(BuildContext context, String storeId) {
  context.navigator.pushStoreDetails(StoreDetailsArgs(storeId: storeId));
}

void navigateToProductDetails(BuildContext context, String productId) {
  context.navigator
      .pushProductDetails(ProductDetailsArgs(productId: productId));
}

void navigateToNotifications(BuildContext context) {
  context.navigator.pushNotifications();
}

void navigateToSearch(BuildContext context) {
  context.navigator.pushSearch();
}

void navigateToFilterDialog(BuildContext context) {
  // TODO: Implement filter dialog
}

void navigateToCategoryDetails(
  BuildContext context,
  String categoryId,
  String categoryName,
) {
  context.navigator.pushCategoryDetails(
    CategoryDetailsArgs(
      categoryId: categoryId,
      categoryName: categoryName,
    ),
  );
}
