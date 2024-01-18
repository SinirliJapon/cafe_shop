import 'package:auto_route/auto_route.dart';
import 'package:cafe_shop/resource/styles.dart';
import 'package:cafe_shop/resource/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cafe_shop/model/cafe_item.dart';
import 'package:cafe_shop/provider/cafe_provider.dart';
import 'package:cafe_shop/widgets/cart_leading.dart';
import 'package:cafe_shop/widgets/cart_trailing.dart';

@RoutePage()
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final CafeProvider cafeProvider = Provider.of<CafeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColor.primaryColor,
        surfaceTintColor: Colors.transparent,
        title: const Center(child: Text('Cart', style: Styles.titleTextStyle)),
      ),
      body: Consumer<CafeProvider>(
        builder: (context, item, child) {
          if (item.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (item.cartItems.isEmpty) {
            return const Center(child: Text('Cart is empty'));
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: item.cartItems.length,
                    itemBuilder: (context, index) {
                      final CafeItem cartItem = item.cartItems[index];
                      final int quantity = item.itemQuantities[cartItem.id] ?? 0;
                      final double totalItemPrice = quantity * double.parse(cartItem.price.toString());

                      return ListTile(
                        leading: CartLeading(quantity: quantity, screenWidth: screenWidth, cartItem: cartItem),
                        title: Text(cartItem.name, style: Styles.cafeTitleTextStyle),
                        subtitle: Text("${totalItemPrice.toStringAsFixed(2)} PLN", style: Styles.cafeSubtitleTextStyle),
                        trailing: CartTrailing(cartItem: cartItem),
                        shape: const Border(bottom: BorderSide(width: 1.0, color: ThemeColor.primaryColor)),
                        tileColor: Colors.grey[200],
                      );
                    },
                  ),
                ),
                ListTile(
                  title: Text('Total: ${item.calculateTotalPrice().toStringAsFixed(2)} PLN', style: Styles.titleTextStyle),
                  iconColor: ThemeColor.foregroundColor,
                  tileColor: ThemeColor.primaryColor,
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: cafeProvider.clearCart),
    );
  }
}
