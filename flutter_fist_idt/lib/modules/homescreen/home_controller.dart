import 'package:flutter_fist_idt/config/config.dart';
import 'package:flutter_fist_idt/data/model/product.dart';
import 'package:flutter_fist_idt/modules/homescreen/home_provider.dart';
import 'package:get/get.dart';

import '../../data/model/cart_item_model.dart';
import '../../widget/notify.dart';

class HomeController extends GetxController {
  final listProduct = <ProductModel>[].obs;
  final listCartItemModel = <CartItemModel>[].obs;

  final indexHomePage = 0.obs;
  Future<void> getListProduct() async {
    final provider = HomeProvider();
    final result = await provider.getListProduct().catchError((err) {
      return Notify.error(err);
    });
    if (result != null) {
      listProduct.value = result;
    }
  }

  Future<void> addProductToCart(productId) async {
    if (token != null) {
      final provider = HomeProvider();
      final result =
          await provider.addProductToCart(productId).catchError((err) {
        return Notify.error(err);
      });
      if (result != null) {
        listCartItemModel.value = result;
      }
    } else {
      Notify.error("please login!");
    }
  }

  @override
  void onInit() {
    getListProduct();
    // TODO: implement onInit
    super.onInit();
  }
}
