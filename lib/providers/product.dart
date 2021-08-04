import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id, title, description, imageUrl;
  final double price;
  bool isFavorite;

  Product(
      {this.id,
      this.title,
      this.description,
      this.imageUrl,
      this.price,
      this.isFavorite = false});

  void toggleFavirote() {
    this.isFavorite = !this.isFavorite;
    notifyListeners();
  }
}
