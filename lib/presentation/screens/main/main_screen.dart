import 'package:flutter/material.dart';
import '../../../core/design_system/widgets/bottom_nav_bar.dart';
import '../../home/home_screen.dart';
import '../cart_screen.dart';
import '../customize_your_product_screen/CustomizeYourProductScreen.dart';
import '../account_screen.dart';
import '../thrift_screen.dart';

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
