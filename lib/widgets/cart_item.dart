import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';

class CartItem extends StatelessWidget {
  final String? id;
  final String? productId;
  final String? title;
  final double? price;
  final int? quantity;
  final String? image;

  const CartItem(
      {Key? key,
      this.id,
      this.productId,
      this.title,
      this.price,
      this.quantity,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId!);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              // child: Text(price!.toString()),
              child: FittedBox(
                child: Image.network(image!),
              ),
            ),
            title: Text(title!),
            subtitle: Text(" \$ الاحمالي ${(quantity! * price!.toInt())}  "),
            trailing: Text("$quantity x  $price"),
          ),
        ),
      ),
    );
  }
}
