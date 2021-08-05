import 'package:flutter/material.dart';
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
            )
          ],
        ),
        body: ProductsGrid(_showFavorites));
  }
}
