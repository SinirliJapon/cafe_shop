import 'package:cafe_shop/model/order.dart';
import 'package:cafe_shop/provider/cafe_provider.dart';
import 'package:cafe_shop/repository/order_history.dart';
import 'package:cafe_shop/resource/styles.dart';
import 'package:cafe_shop/resource/theme_color.dart';
import 'package:cafe_shop/widgets/cart_leading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderHistoryListView extends StatelessWidget {
  const OrderHistoryListView({
    Key? key,
    required this.cafeProvider,
    required this.screenWidth,
  }) : super(key: key);

  final CafeProvider cafeProvider;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: OrderHistory.orderBox.length,
      itemBuilder: (context, index) {
        final Order order = OrderHistory.orderBox.getAt(index) as Order;
        final reversedIndex = OrderHistory.orderBox.length - 1 - index;

        return ExpansionTile(
          leading: const Icon(Icons.history),
          title: Text('Order-${reversedIndex + 1}', style: Styles.orderTitleTextStyle),
          subtitle: Text('Total: ${order.totalPrice.toStringAsFixed(2)} PLN', style: Styles.orderSubtitleTextStyle),
          trailing: Text(DateFormat('dd/MM/yyyy').format(order.orderDate), style: Styles.orderTrailingTextStyle),
          backgroundColor: ThemeColor.tileColor,
          textColor: ThemeColor.primaryColor,
          iconColor: ThemeColor.primaryColor,
          collapsedBackgroundColor: ThemeColor.primaryColor[400],
          collapsedTextColor: ThemeColor.foregroundColor,
          collapsedIconColor: ThemeColor.foregroundColor,
          children: order.orderItems
              .map(
                (orderItem) => ListTile(
                  minVerticalPadding: 10,
                  shape: const Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
                  leading: CartLeading(
                    quantity: orderItem.quantity,
                    cartItem: cafeProvider.getCafeItemById(orderItem.cafeItemId)!,
                    screenWidth: screenWidth,
                  ),
                  title: Text(cafeProvider.getCafeItemById(orderItem.cafeItemId)!.name, style: Styles.orderTitleTextStyle),
                  subtitle: Text(
                    "${(cafeProvider.getCafeItemById(orderItem.cafeItemId)!.price * orderItem.quantity).toStringAsFixed(2)} PLN",
                    style: Styles.orderSubtitleTextStyle,
                  ),
                  tileColor: ThemeColor.tileColor,
                ),
              )
              .toList(),
        );
      },
    );
  }
}
