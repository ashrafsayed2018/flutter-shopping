import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

import "../provider/orders.dart" as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem? order;
  const OrderItem({Key? key, this.order}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("\$ ${widget.order?.amount}"),
            subtitle:
                Text(DateFormat('dd MM yyyy hh:mm').format(DateTime.now())),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: min(widget.order!.products!.length * 20.0 + 30, 280),
              child: ListView(
                children: widget.order!.products!
                    .map((product) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' ${product.quantity} x  \$ ${product.price}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              product.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
