import 'package:flutter/material.dart';
import 'package:flutter_fist_idt/modules/authen/page/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'modules/authen/page/login/login_sreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  await GetStorage.init().then((value) {
    return null;
  });
  Get.put(UserController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      home: LoginScreen(),
    );
  }
}
