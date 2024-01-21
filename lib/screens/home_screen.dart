import 'package:auto_route/auto_route.dart';
import 'package:cafe_shop/resource/theme_color.dart';
import 'package:cafe_shop/screens/cart_screen.dart';
import 'package:cafe_shop/screens/menu_screen.dart';
import 'package:cafe_shop/screens/order_history_screen.dart';
import 'package:cafe_shop/widgets/drawer_list_tile.dart';
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

  void navigateDrawerItem(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  String getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Shop';
      case 1:
        return 'Cart';
      case 2:
        return 'History';
      default:
        return 'Cafe App';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getAppBarTitle()),
        backgroundColor: ThemeColor.primaryColor,
        foregroundColor: ThemeColor.foregroundColor,
      ),
      drawer: Drawer(
        child: Container(
          color: ThemeColor.tileColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                padding: EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(color: ThemeColor.primaryColor),
                child: Center(child: Text('Cafe App', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.white))),
              ),
              DrawerListTile(
                title: 'Cafe Shop',
                icon: Icons.coffee,
                onTap: () {
                  Navigator.pop(context);
                  navigateDrawerItem(0);
                },
              ),
              const Divider(color: ThemeColor.primaryColor),
              DrawerListTile(
                title: 'Cart',
                icon: Icons.shopping_cart,
                onTap: () {
                  Navigator.pop(context);
                  navigateDrawerItem(1);
                },
              ),
              const Divider(color: ThemeColor.primaryColor),
              DrawerListTile(
                title: 'Order History',
                icon: Icons.history,
                onTap: () {
                  Navigator.pop(context);
                  navigateDrawerItem(2);
                },
              ),
              const Divider(color: ThemeColor.primaryColor),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: const [
          MenuScreen(),
          CartScreen(),
          OrderHistoryScreen(),
        ],
      ),
    );
  }
}
