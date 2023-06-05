import 'package:dio/dio.dart';
import 'package:flutter_fist_idt/config/config.dart';

import '../../data/model/cart_item_model.dart';

class CartProvider {
  final dio = Dio();
  CartProvider() {
    dio.options.baseUrl = kBaseUrl;
    if (token != null) {
      dio.options.headers = {'Authorization': 'Bearer $token'};
    }
  }
  Future<List<CartItemModel>?> getListCartItem() async {
    try {
      final response = await dio.get('/cart/cart/');
      if (response.statusCode == 200) {
        return (response.data['items'] as List)
            .map((e) => CartItemModel.fromJson(e))
            .toList();
      }
    } on DioError catch (e) {
      throw e.response?.data ?? e.toString();
    } catch (e) {
      throw e.toString();
    }
    return null;
  }

  Future<void> createOrder() async {
    try {
      await dio.post('/order/order/');
    } on DioError catch (e) {
      throw e.response?.data ?? e.toString();
    } catch (e) {
      throw e.toString();
    }
    return;
  }

  Future<List<CartItemModel>?> addProductToCart(int productId) async {
    try {
      final response = await dio.put('/cart/add/$productId');
      if (response.statusCode == 200) {
        return (response.data['items'] as List)
            .map((e) => CartItemModel.fromJson(e))
            .toList();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw e.response?.data['error'];
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }
}
