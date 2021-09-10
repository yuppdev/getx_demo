import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/state/products.dart';

import 'wish_list_screen.dart';

class HomeScreen extends StatelessWidget {
  final Products _p = Get.put(Products());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Getx Demo App'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
              width: 300,
              height: 80,
              color: Colors.red,
              alignment: Alignment.center,
              child: Obx(() => Text(
                    'Wish List: ${_p.wishListItems.length}',
                    style: const TextStyle(fontSize: 28, color: Colors.white),
                  )),
            ),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => WishListScreen())),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _p.items.length,
              itemBuilder: (context, index) {
                final product = _p.items[index];
                return Card(
                  key: ValueKey(product.id),
                  margin: const EdgeInsets.all(5),
                  color: Colors.amberAccent,
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                    trailing: Obx(() => IconButton(
                      onPressed: () {
                        if (product.inWishList.value == false) {
                          _p.addItem(product.id);
                          // product.inWishList.value = true;
                        } else {
                          _p.removeItem(product.id);
                          // product.inWishList.value = false;
                        }
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: product.inWishList.value == false
                            ? Colors.white
                            : Colors.red,
                      ),
                    )),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
