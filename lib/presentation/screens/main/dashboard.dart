import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design_system/widgets/sellio_bottom_nav_bar.dart';

class Dashboard extends StatefulWidget {
  final int screenIndex;
  final StatefulNavigationShell navigationShell;

  const Dashboard({
    super.key,
    required this.navigationShell,
    this.screenIndex = 0,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void _onItemTapped(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: SellioBottomNavBar(
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (index) {
          setState(() {
            _onItemTapped(index);
            print("index : $index");
          });
        },
        onCenterButtonTap: () {
          setState(() {
            _onItemTapped(2);
            print("Center button tapped");
          });
        },
      ),
    );
  }
}
