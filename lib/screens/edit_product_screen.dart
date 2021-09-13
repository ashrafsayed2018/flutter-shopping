import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routeName = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var _imageUrlController = TextEditingController();

  // save the form inputs

  void _saveForm() {
    print('form is save');
  }

  @override
  void dispose() {
    // TODO: implement dispose'
    _imageUrlController.dispose();
    super.dispose();
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
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'اسم المنتح',
                  hintTextDirection: TextDirection.rtl,
                ),
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.right,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'سعر المنتح',
                  hintTextDirection: TextDirection.rtl,
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.right,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'وصف المنتح',
                  hintTextDirection: TextDirection.rtl,
                ),
                maxLines: 3,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.multiline,
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
                      onChanged: (val) {
                        setState(() {
                          _imageUrlController.text = val;
                        });
                      },
                      decoration:
                          const InputDecoration(hintText: ' رابط صورة المنتج'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
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
