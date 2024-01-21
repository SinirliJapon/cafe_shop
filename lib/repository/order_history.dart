import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:cafe_shop/model/order.dart';

class OrderHistory extends ChangeNotifier {
  static Box<Order> orderBox = Hive.box<Order>(orderHistoryBoxName);
  var uuid = const Uuid();

  void addOrder(List<OrderItem> orderItems, double totalPrice) {
    final String newId = uuid.v4();
    final Order newOrder = Order(
      orderItems: orderItems,
      totalPrice: totalPrice,
      orderDate: DateTime.now(),
    );

    orderBox.put(newId, newOrder);
    notifyListeners();
  }
}
