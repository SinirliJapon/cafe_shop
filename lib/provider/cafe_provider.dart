import 'dart:convert';

import 'package:cafe_shop/model/cafe_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CafeProvider extends ChangeNotifier {
  final List<CafeItem> _cartItems = [];
  final Map<int, int> _itemQuantities = {};
  late bool isLoading = false;
  List<CafeItem> _drinkItems = [];
  List<CafeItem> _desertItems = [];
  List<CafeItem> _breakfastItems = [];
  List<CafeItem> _sandwichItems = [];

  List<CafeItem> get drinkItems => _drinkItems;
  List<CafeItem> get dessertItems => _desertItems;
  List<CafeItem> get breakfastItems => _breakfastItems;
  List<CafeItem> get sandwichItems => _sandwichItems;
  List<CafeItem> get cartItems => _cartItems;
  Map<int, int> get itemQuantities => _itemQuantities;

  Future<void> fetchMenuData() async {
    isLoading = true;
    notifyListeners();
    try {
      final String jsonData = await rootBundle.loadString('assets/data/data.json');
      final Map<String, dynamic> parsedJson = jsonDecode(jsonData);
      final List<dynamic> drinkList = parsedJson['drinks'];
      final List<dynamic> dessertList = parsedJson['desserts'];
      final List<dynamic> breakfastList = parsedJson['breakfast'];
      final List<dynamic> sandwichList = parsedJson['sandwiches'];
      _drinkItems = drinkList.map((e) => CafeItem.fromJson(e)).toList();
      _desertItems = dessertList.map((e) => CafeItem.fromJson(e)).toList();
      _breakfastItems = breakfastList.map((e) => CafeItem.fromJson(e)).toList();
      _sandwichItems = sandwichList.map((e) => CafeItem.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  CafeItem? getCafeItemById(int cafeItemId) {
    for (var item in _drinkItems) {
      if (item.id == cafeItemId) {
        return item;
      }
    }

    for (var item in _desertItems) {
      if (item.id == cafeItemId) {
        return item;
      }
    }

    for (var item in _breakfastItems) {
      if (item.id == cafeItemId) {
        return item;
      }
    }

    for (var item in _sandwichItems) {
      if (item.id == cafeItemId) {
        return item;
      }
    }

    return null;
  }

  void addToCart(CafeItem item) {
    final existingItemIndex = _cartItems.indexWhere((cartItem) => cartItem.id == item.id);

    if (existingItemIndex != -1) {
      _itemQuantities[item.id] = (_itemQuantities[item.id] ?? 0) + 1;
    } else {
      _cartItems.add(item);
      _itemQuantities[item.id] = 1;
    }

    notifyListeners();
  }

  void removeFromCart(CafeItem item) {
    final existingItemIndex = _cartItems.indexWhere((cartItem) => cartItem.id == item.id);

    if (existingItemIndex != -1) {
      _itemQuantities[item.id] = (_itemQuantities[item.id] ?? 0) - 1;

      if (_itemQuantities[item.id] == 0) {
        _cartItems.remove(item);
        _itemQuantities.remove(item.id);
      }
    }

    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    _itemQuantities.clear();
    notifyListeners();
  }

  double calculateTotalPrice() {
    return _cartItems.fold(0.0, (total, item) {
      final int quantity = _itemQuantities[item.id] ?? 0;
      return total + (double.parse(item.price.toString()) * quantity);
    });
  }
}
