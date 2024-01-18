import 'package:auto_route/auto_route.dart';
import 'package:cafe_shop/resource/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cafe_shop/provider/cafe_provider.dart';
import 'package:cafe_shop/widgets/cafe_item_list_widget.dart';

@RoutePage()
class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Map<int, int> itemQuantities = {};

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => Provider.of<CafeProvider>(context, listen: false).fetchMenuData());
  }

  @override
  Widget build(BuildContext context) {
    final CafeProvider cafeProvider = Provider.of<CafeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Center(child: Text('Cafe Restaurant', style: Styles.titleTextStyle)),
      ),
      drawer: const Drawer(),
      body: Consumer<CafeProvider>(
        builder: (context, item, child) {
          if (item.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (item.drinkItems.isEmpty && item.dessertItems.isEmpty) {
            return const Center(child: Text('Menu is empty'));
          } else {
            return ListView(
              children: [
                CafeItemListWidget(
                  items: item.drinkItems,
                  categoryTitle: 'Drinks',
                  icon: Icons.local_cafe_outlined,
                  onAddToCart: cafeProvider.addToCart,
                ),
                CafeItemListWidget(
                  items: item.dessertItems,
                  categoryTitle: 'Desserts',
                  icon: Icons.cookie_outlined,
                  onAddToCart: cafeProvider.addToCart,
                ),
                CafeItemListWidget(
                  items: item.breakfastItems,
                  categoryTitle: 'Breakfast',
                  icon: Icons.egg_outlined,
                  onAddToCart: cafeProvider.addToCart,
                ),
                CafeItemListWidget(
                  items: item.sandwichItems,
                  categoryTitle: 'Sandwiches',
                  icon: Icons.breakfast_dining_outlined,
                  onAddToCart: cafeProvider.addToCart,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
