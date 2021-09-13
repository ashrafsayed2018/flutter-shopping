import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import '../provider/products.dart';
import '/screens/edit_product_screen.dart';

class UserProducts extends StatelessWidget {
  const UserProducts({Key? key}) : super(key: key);

  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('منتجاتك'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: AppDrawer(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          padding: const EdgeInsets.all(10),
          separatorBuilder: (BuildContext context, int index) => Divider(
            thickness: 1,
            height: 1,
            color: Theme.of(context).primaryColorLight,
          ),
          itemCount: productData.items.length,
          itemBuilder: (cxt, index) => UserProductItem(
            id: productData.items[index].id,
            title: productData.items[index].title,
            imageUrl: productData.items[index].imageUrl,
          ),
        ),
      ),
    );
  }
}
