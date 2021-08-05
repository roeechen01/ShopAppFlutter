import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Menu'),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.shopping_bag,
                size: 20,
              ),
              title: Text(
                'Shop',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () => Navigator.of(context).pushReplacementNamed('/'),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.credit_card,
                size: 20,
              ),
              title: Text(
                'Orders',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
