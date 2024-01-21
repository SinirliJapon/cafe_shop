import 'package:hive/hive.dart';

part 'order.g.dart';

const String orderHistoryBoxName = 'orderHistoryBox';

@HiveType(typeId: 1)
class Order extends HiveObject {
  @HiveField(0)
  final List<OrderItem> orderItems;

  @HiveField(1)
  final double totalPrice;

  @HiveField(2)
  final DateTime orderDate;

  Order({
    required this.orderItems,
    required this.totalPrice,
    required this.orderDate,
  });
}

@HiveType(typeId: 2)
class OrderItem {
  @HiveField(0)
  final int cafeItemId;

  @HiveField(1)
  final int quantity;

  OrderItem({
    required this.cafeItemId,
    required this.quantity,
  });
}
