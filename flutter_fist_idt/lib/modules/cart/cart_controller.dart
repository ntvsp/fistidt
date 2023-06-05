import 'package:get/get.dart';

import '../../data/model/cart_item_model.dart';
import '../../widget/notify.dart';
import 'cart_provider.dart';

class CarController extends GetxController {
  final listCartItemModel = <CartItemModel>[].obs;
  final _provider = CartProvider();

  final indexHomePage = 0.obs;
  Future<void> getListCartItem() async {
    final result = await _provider.getListCartItem().catchError((err) {
      return Notify.error(err);
    });
    if (result != null) {
      listCartItemModel.value = result;
    }
  }

  @override
  void onInit() {
    getListCartItem();
    super.onInit();
  }
}
