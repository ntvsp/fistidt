import 'package:flutter/material.dart';
import 'package:flutter_fist_idt/modules/authen/page/login/login_controller.dart';
import 'package:get/get.dart';

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
                      onPressed: () {},
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
