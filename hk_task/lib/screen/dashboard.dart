import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hk_task/controller/custom_controller.dart';
import 'package:hk_task/screen/new_product_sccreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final controller = CustomController();
  List products = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      products = await controller.getProducts();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const NewProductScreen();
            })).then((value) {
              if (value != null) {
                setState(() {
                  products.add(value);
                });
              }
            });
          },
          child: const Icon(Icons.add, color: Colors.white)),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300),
                    child: const Center(child: Icon(Icons.arrow_back_ios)),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade100),
                    child: const Center(child: Icon(Icons.search)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              'Hi-Fi Shop & Service',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 18),
            const Text(
              'Audio shop on Rustaveli Ave 57',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 5),
            const Text(
              'This shop offers both products and services',
              style: TextStyle(color: Colors.grey),
            ),
            ...List.generate(products.length, (index) {
              final prod = products[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Image.file(File(prod['img']))),
                      SizedBox(height: 20),
                      Text(prod['name']),
                      SizedBox(height: 20),
                      Text('\$  ${prod['price']}')
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      )),
    );
  }
}
