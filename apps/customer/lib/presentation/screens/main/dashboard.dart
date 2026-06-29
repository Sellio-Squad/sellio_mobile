import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sellio_mobile/presentation/screens/main/customer_bottom_nav_bar.dart';

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
      bottomNavigationBar: CustomerBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onItemTapped,
        onCenterButtonTap: () => _onItemTapped(2),
      ),
    );
  }
}
