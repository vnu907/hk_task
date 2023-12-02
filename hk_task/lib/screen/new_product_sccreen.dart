import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({super.key});

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  final key = GlobalKey<FormState>();
  final product = TextEditingController();
  final price = TextEditingController();
  String img = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Form(
          key: key,
          child: Column(
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field Required";
                  }
                  return null;
                },
                controller: product,
                decoration:
                    const InputDecoration(hintText: 'Enter Product Name'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field Required";
                  }
                  return null;
                },
                controller: price,
                decoration:
                    const InputDecoration(hintText: 'Enter Product Price'),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  final rawImg = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (rawImg != null) {
                    setState(() {
                      img = rawImg.path;
                    });
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12)),
                  child:
                      img == '' ? const Icon(Icons.add) : Image.file(File(img)),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    if (key.currentState!.validate() && img != '') {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      final data = pref.get('products');
                      if (data != null) {
                        final List listData = jsonDecode(data.toString());
                        listData.add({
                          'name': product.text,
                          'price': product.text,
                          'img': img
                        });
                        pref.setString('products', jsonEncode(listData));
                      } else {
                        pref.setString(
                          'products',
                          jsonEncode([
                            {
                              'name': product.text,
                              'price': product.text,
                              'img': img
                            }
                          ]),
                        );
                      }

                      Navigator.pop(context, {
                        'name': product.text,
                        'price': product.text,
                        'img': img
                      });
                    } else {
                      Fluttertoast.showToast(msg: 'Please Enter Details');
                    }
                  },
                  child: const Text('Add'))
            ],
          ),
        ),
      ),
    );
  }
}
