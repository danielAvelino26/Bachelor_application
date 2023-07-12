import 'dart:async';
import 'package:crossplateforme/product.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem(this.product, this.quantity);
}

class Cart {
  final List<CartItem> items = [];
  ValueNotifier<int> itemCountNotifier = ValueNotifier(0);

  void _updateItemCount() {
    itemCountNotifier.value =
        items.fold(0, (total, item) => total + item.quantity);
  }

  void add(Product product) {
    Stopwatch stopwatch = Stopwatch()..start();
    var item =
        items.firstWhereOrNull((element) => element.product.id == product.id);

    if (item == null) {
      items.add(CartItem(product, 1));
    } else {
      item.quantity++;
    }
    _updateItemCount();
    print('Cart.add() executed in ${stopwatch.elapsed}');
    stopwatch.stop();
  }

  void remove(Product product) {
    Stopwatch stopwatch = Stopwatch()..start();
    var item =
        items.firstWhereOrNull((element) => element.product.id == product.id);

    if (item != null) {
      if (item.quantity == 1) {
        items.remove(item);
      } else {
        item.quantity--;
      }
    }
    _updateItemCount();
    print('Cart.remove() executed in ${stopwatch.elapsed}');
    stopwatch.stop();
  }

  double getTotalPrice() {
    return items.fold(0, (previousValue, element) {
      return previousValue + element.product.price * element.quantity;
    });
  }
}
