import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_products_screen.dart';

class UserProductItem extends StatelessWidget {
  String title, imageUrl;

  UserProductItem({this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(title),
        trailing: Container(
            width: 100,
            child: Row(children: [
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(EditProductsScreen.routeName),
                  color: Theme.of(context).primaryColor),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},
                  color: Theme.of(context).errorColor)
            ])));
  }
}
