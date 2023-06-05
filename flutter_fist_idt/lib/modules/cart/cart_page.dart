import 'package:flutter/material.dart';
import 'package:flutter_fist_idt/modules/cart/cart_controller.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final controller = Get.put(CarController())..getListCartItem();
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.listCartItemModel.isEmpty
        ? const CircularProgressIndicator()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            itemCount: controller.listCartItemModel.length,
            itemBuilder: (_, index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.purple)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.listCartItemModel[index].product?.name ?? "",
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                        "${controller.listCartItemModel[index].product?.price ?? 0} \$"),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                        "Owner: ${controller.listCartItemModel[index].product?.owner!.username ?? 0}"),
                    Text(
                        "Quantity: ${controller.listCartItemModel[index].quantity ?? 0}"),
                  ],
                )),
          ));
  }
}
