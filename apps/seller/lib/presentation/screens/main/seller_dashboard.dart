import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'seller_bottom_nav_bar.dart';

class SellerDashboard extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const SellerDashboard({
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
      bottomNavigationBar: SellerBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onItemTapped,
        onCenterButtonTap: () => _onItemTapped(2),
      ),
    );
  }
}
