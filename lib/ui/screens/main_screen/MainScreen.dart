import 'package:flutter/material.dart';
import '../../../core/design_system/widgets/bottom_nav_bar.dart';
import '../FavoritesScreen.dart';
import '../HomeScreen.dart';
import '../ProfileScreen.dart';
import '../SearchScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoritesScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  void _onCenterButtonTapped() {
    // Handle center button action (e.g., create new post, add item, etc.)
    print('Center button tapped!');
    // You can navigate to a new screen or show a dialog
    // Navigator.push(context, MaterialPageRoute(builder: (context) => AddItemScreen()));
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
