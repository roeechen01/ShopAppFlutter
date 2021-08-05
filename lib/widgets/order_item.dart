import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem orderItem;
  OrderItem(this.orderItem);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderItem.amount}'),
            subtitle: Text(DateFormat('dd/MM/yyyyy hh:mm')
                .format(widget.orderItem.dateTime)),
            trailing: IconButton(
                icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () => setState(() {
                      expanded = !expanded;
                    })),
          ),
          if (expanded)
            Container(
                height:
                    min(widget.orderItem.products.length * 10 + 100.0, 100.0),
                child: ListView(
                    children: widget.orderItem.products
                        .map((product) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    product.title,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    '${product.quantity}x \$${product.price}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              ],
                            ))
                        .toList()))
        ],
      ),
    );
  }
}
