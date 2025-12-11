import 'package:flutter/material.dart';

import '../../../../core/navigate/navigation_extensions.dart';


void navigateToMyOrders(BuildContext context) {
  context.navigator.pushMyOrders();
}

void navigateToMyFavourites(BuildContext context) {
  context.navigator.pushMyFavorites();
}

void navigateToLoginScreen(BuildContext context) {
  context.navigator.replaceWithLogin();
}

void navigateToAppVersion(BuildContext context) {
  // TODO: Implement app version navigation
}
