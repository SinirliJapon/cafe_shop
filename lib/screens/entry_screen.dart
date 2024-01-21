import 'package:auto_route/auto_route.dart';
import 'package:cafe_shop/resource/theme_color.dart';
import 'package:cafe_shop/widgets/enter_shop_button.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(backgroundColor: Colors.brown, foregroundColor: Colors.white, title: const Center(child: Text('Welcome to Cafe Shop'))),
      body: Center(child: Icon(Icons.coffee, size: screenHeight / 3, color: ThemeColor.primaryColor)),
      floatingActionButton: const EnterShopButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
