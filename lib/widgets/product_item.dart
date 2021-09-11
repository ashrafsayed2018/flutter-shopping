import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product.dart';
import '../provider/cart.dart';
import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  // final String? id;
  // final String? title;
  // final String? imageUrl;

  // const ProductItem({Key? key, this.id, this.title, this.imageUrl})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailsScreen.routeName, arguments: product.id);
        },
        child: Image.network(
          product.imageUrl!,
          fit: BoxFit.cover,
        ),
      ),
      footer: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                  product.isFavorite! ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.toggleFavoriteState();
              },
              color: Theme.of(context).primaryColor,
            ),
            // child: Text('never changed'),
          ),
          title: Text(
            product.title!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id!, product.title!, product.price!,
                  product.imageUrl!);
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
