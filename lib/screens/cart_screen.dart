import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "../provider/cart.dart" show Cart;

import "../widgets/cart_item.dart";
import '../provider/orders.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  static const routeName = "cartScreen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('كرت التسوق'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: TextDirection.rtl,
                children: [
                  const Text(
                    'الاجمالي',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  cart.itemCount > 0
                      ? ElevatedButton(
                          onPressed: () {
                            Provider.of<Orders>(context, listen: false)
                                .addOrder(cart.items.values.toList(),
                                    cart.totalAmount);
                            cart.clear();
                          },
                          child: const Text('اطلب الان'),
                        )
                      : Text('')
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, index) => CartItem(
                  id: cart.items.values.toList()[index].id,
                  productId: cart.items.keys.toList()[index],
                  title: cart.items.values.toList()[index].title,
                  price: cart.items.values.toList()[index].price,
                  quantity: cart.items.values.toList()[index].quantity,
                  image: cart.items.values.toList()[index].image),
            ),
          )
        ],
      ),
    );
  }
}
