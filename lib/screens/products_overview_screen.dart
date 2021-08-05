import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions { ShowFavorites, ShowAll }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
          actions: [
            PopupMenuButton(
              onSelected: (value) => setState(() {
                _showFavorites = value == FilterOptions.ShowFavorites;
                print(_showFavorites);
              }),
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text('Show favorites'),
                  value: FilterOptions.ShowFavorites,
                ),
                PopupMenuItem(
                  child: Text('Show all'),
                  value: FilterOptions.ShowAll,
                )
              ],
            ),
            Consumer<Cart>(
                builder: (_, cart, ch) =>
                    Badge(child: ch, value: cart.count.toString()),
                child: IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    }))
          ],
        ),
        body: ProductsGrid(_showFavorites));
  }
}
