import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart' show Cart;
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart_screen';

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.total.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    FlatButton(
                      child: Text(
                        'ORDER NOW',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false)
                            .addOrder(cart.items.values.toList(), cart.total);
                        cart.clear();
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: cart.count,
              itemBuilder: (context, i) => CartItem(
                id: cart.items.values.toList()[i].id,
                productId: cart.items.keys.toList()[i],
                title: cart.items.values.toList()[i].title,
                price: cart.items.values.toList()[i].price,
                quantity: cart.items.values.toList()[i].quantity,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
