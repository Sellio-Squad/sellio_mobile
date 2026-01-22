import 'package:flutter/material.dart';

import '../../../../core/navigate/navigation_extensions.dart';
import '../../../../di/injection_container.dart';
import '../../../../domain/repositories/auth_repository.dart';

void navigateToMyOrders(BuildContext context) {
  context.navigator.pushMyOrders();
}

void navigateToMyFavourites(BuildContext context) {
  context.navigator.pushMyFavorites();
}

Future<void> navigateToLoginScreen(BuildContext context) async {
  final authRepo = sl<AuthRepository>();
  await authRepo.clearAuthData();

  if (context.mounted) {
    context.navigator.pushReplacementLogin();
  }
}

void navigateToAppVersion(BuildContext context) {
  // TODO: Implement app version navigation
}
