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
      final response = await dio.post('/auth/login/', data: data);
      if (response.statusCode == 200) {
        token = response.data['access'];
        //save to getstorage
        return UserModel.fromJson(response.data['user']);
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
