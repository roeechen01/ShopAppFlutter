import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_products_screen.dart';

class UserProductItem extends StatelessWidget {
  String title, imageUrl, id;

  UserProductItem({this.title, this.imageUrl, this.id});

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
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductsScreen.routeName, arguments: id);
                  },
                  color: Theme.of(context).primaryColor),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: Text(
                                    'Are you sure you want to delete item?'),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        Provider.of<Products>(context)
                                            .removeProduct(id);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(
                                          color: Theme.of(context).errorColor,
                                        ),
                                      )),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('No'),
                                  )
                                ]));
                  },
                  color: Theme.of(context).errorColor)
            ])));
  }
}
