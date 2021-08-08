import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  CartItem(
      {@required this.id,
      @required this.productId,
      @required this.title,
      @required this.price,
      @required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
            size: 40,
          ),
        ),
      ),
      onDismissed: (_) {
        Provider.of<Cart>(context).removeItem(productId);
      },
      confirmDismiss: (_) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you want to remove item from the cart?'),
                  actions: [
                    FlatButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: Text('Yes')),
                    FlatButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: Text('No'))
                  ],
                ));
      },
      key: ValueKey(id),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: FittedBox(
                child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(price.toString()),
            )),
          ),
          title: Text(title),
          subtitle: Text('Total: \$${price * quantity}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
