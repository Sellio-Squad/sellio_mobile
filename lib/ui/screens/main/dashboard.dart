import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_management/route/app_navigator.dart';
import '../../../core/app_management/route/app_navigator_impl.dart';
import '../../../core/design_system/widgets/bottom_nav_bar.dart';

class Dashboard extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const Dashboard({
    super.key,
    required this.navigationShell,
  });

  void _onItemTapped(int index) {

    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onItemTapped,
        onCenterButtonTap: () {
          AppNavigatorImpl(context).goToCustomDesign();
        },
      ) ,
    );
  }
}