import 'package:auto_route/auto_route.dart';
import 'package:cafe_shop/screens/cart_screen.dart';
import 'package:cafe_shop/screens/menu_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: const Cubic(0.25, 0.1, 0.25, 1),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: const [
          MenuScreen(),
          CartScreen(),
        ],
      ),
      bottomNavigationBar: GNav(
        color: Colors.grey[400],
        selectedIndex: _selectedIndex,
        onTabChange: navigateBottomBar,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        tabActiveBorder: Border.all(color: Colors.brown, width: 2),
        tabMargin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(12.0),
        tabBorderRadius: 12,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Shop',
            textColor: Colors.brown,
            iconActiveColor: Colors.brown,
          ),
          GButton(
            icon: Icons.shopping_cart_outlined,
            text: 'Cart',
            textColor: Colors.brown,
            iconActiveColor: Colors.brown,
          ),
        ],
      ),
    );
  }
}
