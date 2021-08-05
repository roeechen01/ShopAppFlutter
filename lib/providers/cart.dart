import 'package:flutter/foundation.dart';

class CartItem {
  String id;
  String title;
  double price;
  int quantity;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get count => _items.length;

  double get total {
    double total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addCartItem(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (oldItem) => CartItem(
              id: oldItem.id,
              title: oldItem.title,
              price: oldItem.price,
              quantity: oldItem.quantity + 1));
    } else {
      _items.putIfAbsent(
          id,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
  }
}
