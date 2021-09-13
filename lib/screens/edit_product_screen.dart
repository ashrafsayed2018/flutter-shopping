import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';
import '../provider/product.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routeName = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _initValues = {
    'title': '',
    'price': '',
    'description': "",
    'imageUrl': ""
  };

  var _editedProduct =
      Product(id: null, title: '', description: '', price: 0, imageUrl: '');

  // save the form inputs

  void _saveForm() {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    if (_editedProduct != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id!, _editedProduct);
      Navigator.of(context).pop();
    } else {
      Provider.of<Products>(context, listen: false).addPoduct(_editedProduct);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose'
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final String? productId =
          ModalRoute.of(context)!.settings.arguments as String?;
      print(productId);
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title!,
          'price': _editedProduct.price!.toString(),
          'description': _editedProduct.description!,
          'imageUrl': _editedProduct.imageUrl!
        };
        _imageUrlController.text = _initValues['imageUrl']!;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل المتجات'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                decoration: const InputDecoration(
                  hintText: 'اسم المنتح',
                  hintTextDirection: TextDirection.rtl,
                ),
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.right,
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite,
                    title: value,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    price: _editedProduct.price,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: const InputDecoration(
                  hintText: 'سعر المنتح',
                  hintTextDirection: TextDirection.rtl,
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.right,
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    price: double.parse(value!),
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  if (double.tryParse(value) == null) {
                    return "الرحاء ادخال سعر صحيح";
                  }

                  if (double.parse(value) <= 0) {
                    return "الرجاء ادخال سعر اكبر من 0";
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: const InputDecoration(
                  hintText: 'وصف المنتح',
                  hintTextDirection: TextDirection.rtl,
                ),
                maxLines: 3,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite,
                    title: _editedProduct.title,
                    description: value,
                    imageUrl: _editedProduct.imageUrl,
                    price: _editedProduct.price,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  if (value.length < 10) {
                    return 'هذا الحقل يجب ان يكون اكبر من 10 حروف';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Text('اشف رابط الصوره')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.fitWidth,
                            clipBehavior: Clip.hardEdge,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      // initialValue: _initValues['imageUrl'],
                      onChanged: (value) {
                        setState(
                          () {
                            _imageUrlController.text = value;
                          },
                        );
                      },
                      decoration:
                          const InputDecoration(hintText: ' رابط صورة المنتج'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          imageUrl: value,
                          price: _editedProduct.price,
                        );
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'هذا الحقل مطلوب';
                        }
                        if (!value.startsWith('http') ||
                            !value.startsWith('https')) {
                          return 'هذا الحقل يجب ان يكون رابط صحيح';
                        }

                        // if (!value.endsWith('png') ||
                        //     !value.endsWith('jpg') ||
                        //     !value.endsWith('jpeg')) {
                        //   return 'هذا الحقل يجب ان يكون رابط لصوره';
                        // }
                        return null;
                      },
                    ),
                  )
                ],
              ),
              Container(
                width: 50,
                margin: EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(100, 50)),
                  onPressed: () {
                    _saveForm();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      Icon(Icons.save),
                      Text(
                        'اضافة المتنج',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
