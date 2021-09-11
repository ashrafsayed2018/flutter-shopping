import 'package:flutter/material.dart';

class CartItem {
  final String? id;
  final String title;
  final int? quantity;
  final double? price;
  final String? image;

  CartItem(
      {@required this.id,
      required this.title,
      required this.quantity,
      required this.price,
      @required this.image});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartIrem) {
      total += cartIrem.quantity! * cartIrem.price!;
    });
    return total;
  }

  void addItem(String productId, String title, double price, String image) {
    if (_items.containsKey(productId)) {
      // change the quantity
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity! + 1,
              price: existingCartItem.price,
              image: existingCartItem.image));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
          image: image,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // clear the cart after order is make

  void clear() {
    _items = {};
    notifyListeners();
  }
}
