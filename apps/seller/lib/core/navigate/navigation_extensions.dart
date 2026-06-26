import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'app_navigator.dart';

extension NavigationExtension on BuildContext {
  AppNavigator get navigator => GetIt.I<AppNavigator>();
}
