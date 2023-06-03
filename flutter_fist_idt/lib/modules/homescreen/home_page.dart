import 'package:flutter/material.dart';
import 'package:flutter_fist_idt/modules/homescreen/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: 'Cart',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Order History',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: controller.indexHomePage.value,
        selectedItemColor: Colors.purple,
        onTap: (index) {
          controller.indexHomePage.value = index;
        },
      ),
      body: Obx(() => controller.listProduct.isEmpty
          ? const CircularProgressIndicator()
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: controller.listProduct.length,
              itemBuilder: (_, index) => Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.purple)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.listProduct[index].name ?? "",
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text("${controller.listProduct[index].price ?? 0} \$"),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                          "Owner: ${controller.listProduct[index].owner!.username ?? 0}"),
                      TextButton(
                          onPressed: () => controller.addProductToCart(
                              controller.listProduct[index].id),
                          child: const Text("Add to cart"))
                    ],
                  )),
            )),
    );
  }
}
