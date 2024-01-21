import 'package:auto_route/auto_route.dart';
import 'package:cafe_shop/model/order.dart';
import 'package:cafe_shop/repository/order_history.dart';
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
                  flex: 10,
                  child: ListView.builder(
                    itemCount: item.cartItems.length,
                    itemBuilder: (context, index) {
                      final CafeItem cartItem = item.cartItems[index];
                      final int quantity = item.itemQuantities[cartItem.id] ?? 0;
                      final double totalItemPrice = quantity * double.parse(cartItem.price.toString());

                      return ListTile(
                        leading: CartLeading(quantity: quantity, screenWidth: screenWidth, cartItem: cartItem),
                        title: Text(cartItem.name, style: Styles.orderTitleTextStyle),
                        subtitle: Text("${totalItemPrice.toStringAsFixed(2)} PLN", style: Styles.cafeSubtitleTextStyle),
                        trailing: CartTrailing(cartItem: cartItem),
                        shape: const Border(bottom: BorderSide(width: 1.0, color: ThemeColor.primaryColor)),
                        tileColor: ThemeColor.tileColor,
                      );
                    },
                  ),
                ),
                Container(
                  color: ThemeColor.primaryColor,
                  child: ListTile(
                    title: Text('Total: ${item.calculateTotalPrice().toStringAsFixed(2)} PLN', style: Styles.titleTextStyle),
                    trailing: PayButton(cafeProvider: cafeProvider),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class PayButton extends StatelessWidget {
  const PayButton({
    super.key,
    required this.cafeProvider,
  });

  final CafeProvider cafeProvider;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: ThemeColor.foregroundColor,
      icon: const Icon(Icons.payment),
      onPressed: () {
        if (cafeProvider.cartItems.isNotEmpty) {
          final List<OrderItem> orderItems = cafeProvider.cartItems.map((cartItem) {
            return OrderItem(cafeItemId: cartItem.id, quantity: cafeProvider.itemQuantities[cartItem.id] ?? 0);
          }).toList();
          OrderHistory().addOrder(orderItems, cafeProvider.calculateTotalPrice());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: ThemeColor.primaryColor[400],
              duration: const Duration(seconds: 1),
              content: const Text('Your payment has been made successfully!', style: Styles.snackBarTextStyle),
            ),
          );
          cafeProvider.clearCart();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: ThemeColor.primaryColor[400],
              duration: const Duration(seconds: 1),
              content: const Text('Cannot place an order with an empty cart.', style: Styles.snackBarTextStyle),
            ),
          );
        }
      },
    );
  }
}
