import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_app/models/http_exception.dart';

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

  void _setFavStatus(bool status) {
    this.isFavorite = status;
    notifyListeners();
  }

  Future<void> toggleFavirote() async {
    bool oldStatus = this.isFavorite;
    final url =
        'https://shop-app-1e674-default-rtdb.firebaseio.com/Products/$id';
    this.isFavorite = !this.isFavorite;
    notifyListeners();
    try {
      final resposne = await http.patch(url,
          body: json.encode({'isFavorite': this.isFavorite}));
      if (resposne.statusCode >= 400) {
        _setFavStatus(oldStatus);
        throw HttpException('Favorite status update failed!');
      }
    } catch (error) {
      _setFavStatus(oldStatus);
      throw HttpException('Favorite status update failed!');
    }
  }
}
