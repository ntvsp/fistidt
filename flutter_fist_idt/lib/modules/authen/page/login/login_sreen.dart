import 'package:flutter/material.dart';
import 'package:flutter_fist_idt/modules/authen/page/login/login_controller.dart';
import 'package:get/get.dart';

class AuthenScreen extends StatelessWidget {
  AuthenScreen({super.key});
  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => IndexedStack(
          index: controller.authenPage.value,
          children: [LoginScreen(), AuthenScreen()],
        ));
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    Color getColor2(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.green;
      }
      return Colors.blue;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: Get.theme.textTheme.bodyLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernameTextController,
              decoration: const InputDecoration(
                hintText: "Username",
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: passwordTextController,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.resolveWith(getColor),
                        backgroundColor:
                            MaterialStateProperty.resolveWith(getColor2),
                      ),
                      onPressed: () => controller.login(
                          username: usernameTextController.text,
                          password: passwordTextController.text),
                      child: const Text(
                        "Login",
                      )),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.resolveWith(getColor),
                        backgroundColor:
                            MaterialStateProperty.resolveWith(getColor2),
                      ),
                      onPressed: () => controller.authenPage.value = 1,
                      child: const Text(
                        "Register",
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterSreen extends StatelessWidget {
  RegisterSreen({super.key});
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final password2TextController = TextEditingController();

  final controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    Color getColor2(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.green;
      }
      return Colors.blue;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Register", style: Get.theme.textTheme.bodyLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernameTextController,
              decoration: const InputDecoration(
                hintText: "Username",
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: passwordTextController,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: passwordTextController,
              decoration: const InputDecoration(
                hintText: "re-type password",
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.resolveWith(getColor),
                        backgroundColor:
                            MaterialStateProperty.resolveWith(getColor2),
                      ),
                      onPressed: () => controller.authenPage.value = 0,
                      child: const Text(
                        "Login",
                      )),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.resolveWith(getColor),
                        backgroundColor:
                            MaterialStateProperty.resolveWith(getColor2),
                      ),
                      onPressed: () => controller.register(
                            username: usernameTextController.text,
                            password: passwordTextController.text,
                            password2: password2TextController.text,
                          ),
                      child: const Text(
                        "Register",
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
