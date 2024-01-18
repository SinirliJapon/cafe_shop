import 'package:cafe_shop/model/cafe_item.dart';
import 'package:cafe_shop/provider/cafe_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTrailing extends StatelessWidget {
  final CafeItem cartItem;

  const CartTrailing({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CafeProvider cafeProvider = Provider.of<CafeProvider>(context, listen: false);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(onPressed: () => cafeProvider.removeFromCart(cartItem), icon: const Icon(Icons.remove_circle_outline)),
        IconButton(onPressed: () => cafeProvider.addToCart(cartItem), icon: const Icon(Icons.add_circle_outline)),
      ],
    );
  }
}
