import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

import 'edit_products_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user_products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Products'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(EditProductsScreen.routeName),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: Container(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
                itemCount: productsData.items.length,
                itemBuilder: (context, i) => UserProductItem(
                      title: productsData.items[i].title,
                      imageUrl: productsData.items[i].imageUrl,
                      id: productsData.items[i].id,
                    ))));
  }
}
