import 'package:f_talk/base/base_controller.dart';
import 'package:f_talk/ui/chat/chat_detail_page.dart';
import 'package:f_talk/util/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  ///服务器地址文本框
  final TextEditingController addressController =
      TextEditingController(text: "103.145.87.185:32167");
      // TextEditingController(text: "127.0.0.1:32167");

  ///账号文本框
  final TextEditingController accountController = TextEditingController();

  final _isValid = false.obs;

  bool get isValid => _isValid.value;

  @override
  void onInit() {
    super.onInit();

    editListener() {
      _isValid.value = addressController.text.isNotEmpty &&
          accountController.text.isNotEmpty;
    }

    addressController.addListener(editListener);
    accountController.addListener(editListener);
  }

  void login() {
    String address = addressController.text
        .substring(0, addressController.text.indexOf(":"));
    int port = int.tryParse(addressController.text
            .substring(addressController.text.indexOf(":") + 1)) ??
        0;
    startPageAndRemovedAllBottom(const ChatDetailPage(),
        arguments: {"address": address, "port": port, "name": accountController.text});
  }
}
