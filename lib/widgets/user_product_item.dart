import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_products_screen.dart';

class UserProductItem extends StatelessWidget {
  String title, imageUrl, id;

  UserProductItem({this.title, this.imageUrl, this.id});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
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
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductsScreen.routeName, arguments: id);
                  },
                  color: Theme.of(context).primaryColor),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    try {
                      await Provider.of<Products>(context, listen: false)
                          .removeProduct(id);
                    } catch (error) {
                      scaffold.showSnackBar(SnackBar(
                        content: Text(
                          'Deleting failed!',
                          textAlign: TextAlign.center,
                        ),
                      ));
                    }
                  },
                  color: Theme.of(context).errorColor)
            ])));
  }
}
