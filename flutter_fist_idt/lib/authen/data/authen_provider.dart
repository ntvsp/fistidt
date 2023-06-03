import 'package:dio/dio.dart';
import 'package:flutter_fist_idt/config/config.dart';
import 'package:flutter_fist_idt/data/model/user_model.dart';

class AuthenProvider {
  final dio = Dio();
  AuthenProvider() {
    dio.options.baseUrl = kBaseUrl;
  }
  Future<UserModel?> login(
      {required String username, required String password}) async {
    try {
      final data = {"username": username, "password": password};
      final response = await dio.get('/auth/login', data: data);
      if (response.statusCode == 200) {
        return response.data['data']
            .map<UserModel>((json) => UserModel.fromJson(json))
            .toList();
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }

  Future<bool?> register(
      {required String username,
      required String password,
      required String password2}) async {
    try {
      final data = {
        "username": username,
        "password": password,
        "password2": password2
      };
      final response = await dio.get('/auth/register', data: data);
      return response.statusCode == 200;
    } catch (e) {
      throw e.toString();
    }
  }
}
