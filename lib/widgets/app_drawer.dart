import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

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
            Divider(),
            ListTile(
              leading: Icon(
                Icons.edit,
                size: 20,
              ),
              title: Text(
                'Manage Products',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                size: 20,
              ),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
