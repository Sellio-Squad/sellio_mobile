import 'package:flutter/material.dart';

import '../../../../core/navigate/navigation_extensions.dart';

void navigateToMyOrders(BuildContext context) {
  context.navigator.pushMyOrders();
}

void navigateToMyFavourites(BuildContext context) {
  context.navigator.pushMyFavorites();
}

Future<void> navigateToLoginScreen(BuildContext context) async {
  if (context.mounted) {
    context.navigator.pushLogin();
  }
}

void navigateToAppVersion(BuildContext context) {
  // TODO: Implement app version navigation
}
