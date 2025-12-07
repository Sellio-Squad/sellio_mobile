import 'package:flutter/cupertino.dart';

import 'app_navigator.dart';
import 'app_navigator_impl.dart';

extension NavigationHelpersExt on BuildContext {

  AppNavigator get navigator => AppNavigatorImpl(this);
}
