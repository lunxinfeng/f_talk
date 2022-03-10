import 'dart:convert';

import 'package:f_talk/net/socket.dart';
import 'package:f_talk/util/log.dart';
import 'package:get/get.dart';

mixin SocketController {
  String _id = "";
  String? name;

  ///自己的id
  String get id => _id;

  void connectServer(String address, int port) {
    SocketManager.connect(address, port,
        receive: _onReceive, connectFail: _connectFail);
  }

  void sendMessage(String message) {
    Message chat = Message();
    chat.message = message;
    chat.name = name;

    SocketManager.sendMessage(chat);
  }

  void _connectFail() {
    Get.defaultDialog(title: 'connect_fail'.tr);
  }

  void _onReceive(Message message) {
    Log.d(message.message);
    Map<String, dynamic> map = json.decode(message.message);
    if (map.keys.length == 1 && map.containsKey('id')) {
      _id = map['id'];
      return;
    }
    onReceiveMessage(map);
  }

  void onReceiveMessage(Map<String, dynamic> map) {}
}
