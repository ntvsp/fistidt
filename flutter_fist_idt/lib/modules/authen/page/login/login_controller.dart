import 'package:flutter_fist_idt/modules/authen/data/authen_provider.dart';
import 'package:flutter_fist_idt/data/model/user_model.dart';
import 'package:get/get.dart';

import '../../../../widget/notify.dart';
import '../../../homescreen/home_page.dart';

class UserController extends GetxController {
  final currentUser = UserModel().obs;
  final _provider = AuthenProvider();
  Future<void> login(
      {required String username, required String password}) async {
    final result = await _provider
        .login(username: username, password: password)
        .catchError((err) {
      return Notify.error(err);
    });
    if (result != null) {
      currentUser.value = result;
      Get.offAll(() => HomePage());
      Notify.success("login success");
    }
  }
}
