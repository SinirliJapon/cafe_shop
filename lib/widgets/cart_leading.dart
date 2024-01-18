import 'package:cafe_shop/model/cafe_item.dart';
import 'package:cafe_shop/resource/styles.dart';
import 'package:flutter/material.dart';

class CartLeading extends StatelessWidget {
  final int quantity;
  final double screenWidth;
  final CafeItem cartItem;

  const CartLeading({Key? key, required this.quantity, required this.screenWidth, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("x$quantity", style: Styles.cafeTitleTextStyle),
        const SizedBox(width: 10),
        SizedBox(height: screenWidth / 2, child: Image.network(cartItem.image, fit: BoxFit.contain)),
      ],
    );
  }
}
