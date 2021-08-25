import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

import 'edit_products_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user_products';

  Future<void> _refresh(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
          future: _refresh(context),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () => _refresh(context),
                      child: Consumer<Products>(
                        builder: (context, consumerData, child) => Container(
                            padding: EdgeInsets.all(8),
                            child: ListView.builder(
                                itemCount: consumerData.items.length,
                                itemBuilder: (context, i) => UserProductItem(
                                      title: consumerData.items[i].title,
                                      imageUrl: consumerData.items[i].imageUrl,
                                      id: consumerData.items[i].id,
                                    ))),
                      ),
                    )),
    );
  }
}
