import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  // final String? title;
  // final double? price;
  // const ProductDetailsScreen({Key? key, this.title, this.price})
  //     : super(key: key);
  static const routeName = 'product-details';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;

    final loadedProduct = Provider.of<Products>(context).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title!),
      ),
    );
  }
}
