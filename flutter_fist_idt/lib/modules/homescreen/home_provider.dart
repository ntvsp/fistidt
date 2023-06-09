import 'package:dio/dio.dart';
import 'package:flutter_fist_idt/config/config.dart';
import 'package:flutter_fist_idt/data/model/product.dart';

import '../../data/model/cart_item_model.dart';

class HomeProvider {
  final dio = Dio();
  HomeProvider() {
    dio.options.baseUrl = kBaseUrl;
    if (token != null) {
      dio.options.headers = {'Authorization': 'Bearer $token'};
    }
  }
  Future<List<ProductModel>?> getListProduct() async {
    try {
      final response = await dio.get('/product/products/?page_size=999');
      if (response.statusCode == 200) {
        return (response.data['results'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw e.response?.data['error'];
      } else {
        throw e.response?.data ?? e.toString();
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
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
      } else {
        throw e.response?.data ?? e.toString();
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }
}
