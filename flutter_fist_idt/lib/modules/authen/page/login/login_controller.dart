import 'package:flutter_fist_idt/modules/authen/data/authen_provider.dart';
import 'package:flutter_fist_idt/data/model/user_model.dart';
import 'package:flutter_fist_idt/modules/authen/page/login/login_sreen.dart';
import 'package:get/get.dart';

import '../../../../widget/notify.dart';
import '../../../homescreen/home_page.dart';

class UserController extends GetxController {
  final currentUser = UserModel().obs;
  final _provider = AuthenProvider();
  final authenPage = 0.obs;
  Future<void> login(
      {required String username, required String password}) async {
    final result = await _provider
        .login(username: username, password: password)
        .catchError((err) {
      return Notify.error(err);
    });
    if (result != null) {
      currentUser.value = result;
      Get.offAll(() => MasterPage());
      Notify.success("login success");
    }
  }

  Future<void> register(
      {required String username,
      required String password,
      required String password2}) async {
    final result = await _provider
        .register(username: username, password: password, password2: password2)
        .catchError((err) {
      return Notify.error(err);
    });
    if (result != null) {
      Get.offAll(() => LoginScreen());
      Notify.success("register success");
    }
  }
}
