import 'package:flutter/material.dart';

import '../../../core/design_system/widgets/sellio_bottom_nav_bar.dart';
import '../account/account_screen.dart';
import '../cart/cart_screen.dart';
import '../customize_product/customize_your_product_screen.dart';
import '../home/home_screen.dart';
import '../thrift/thrift_screen.dart';

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
    const CustomizeYourProductScreen(),
  ];

  void _onCenterButtonTapped() {
    setState(() {
      _currentIndex = 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: SellioBottomNavBar(
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
