import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product_detail_screen';
  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
        appBar: AppBar(title: Text(loadedProduct.title)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: productId,
              child: Image.network(
                loadedProduct.imageUrl,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              '\$${loadedProduct.price}',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              '${loadedProduct.description}',
              style: TextStyle(fontSize: 15),
            )
          ],
        ));
  }
}
