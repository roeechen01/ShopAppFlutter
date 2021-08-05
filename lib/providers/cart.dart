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
  Map<String, CartItem> _items;
  Map<String, CartItem> get items {
    return {..._items};
  }

  void addCartItem(String id, String title, double price) {
    if (items.containsKey(id)) {
      items.update(
          id,
          (oldItem) => CartItem(
              id: oldItem.id,
              title: oldItem.title,
              price: oldItem.price,
              quantity: oldItem.quantity + 1));
    } else {
      items.putIfAbsent(
          id,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
  }
}
