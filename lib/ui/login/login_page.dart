import 'package:f_talk/util/os_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return Container(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                children: [
                  const Spacer(flex: 4),
                  TextField(
                    controller: controller.addressController,
                    decoration: InputDecoration(
                        labelText: 'server_address'.tr,
                        prefixIcon: const Icon(Icons.person),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)))),
                  ),
                  const Spacer(flex: 1),
                  TextField(
                    controller: controller.accountController,
                    decoration: InputDecoration(
                        labelText: 'account'.tr,
                        prefixIcon: const Icon(Icons.person),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)))),
                  ),
                  const Spacer(flex: 2),
                  ElevatedButton(
                      onPressed: controller.isValid ? controller.login : null,
                      child: Text('login'.tr)),
                  const Spacer(flex: 8),
                ],
              ),
            ),
          );
        });
  }
}
