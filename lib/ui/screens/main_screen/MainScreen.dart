import 'package:flutter/material.dart';
import '../../../core/design_system/widgets/bottom_nav_bar.dart';
import '../CartScreen.dart';
import '../home/home_screen.dart';
import '../AccountScreen.dart';
import '../ThriftScreen.dart';

class MainScreen extends StatefulWidget {
  final int screenIndex;

  const MainScreen({super.key, this.screenIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.screenIndex;
  }


  final List<Widget> _screens = [
    const HomeScreen(),
    const CartScreen(),
    const ThriftScreen(),
    const AccountScreen(),
  ];

  void _onCenterButtonTapped() {
    // Handle center button action
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        onCenterButtonTap: _onCenterButtonTapped,
      ),
    );
  }
}
