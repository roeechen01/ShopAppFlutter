import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeNamte = '/product_detail_screen';
  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
      title: Text('Product'),
    ));
  }
}
