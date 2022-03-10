import 'package:date_format/date_format.dart';
import 'package:f_talk/base/base_controller.dart';
import 'package:f_talk/base/socket_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chat {
  String name;
  String message;
  String time;

  Chat(this.name, this.message, this.time);
}

class ChatDetailController extends BaseController with SocketController {
  final chats = <Chat>[].obs;
  final ScrollController scrollController = ScrollController();
  final TextEditingController messageEditingController =
      TextEditingController();
  final _isPreSend = false.obs;

  ///是否解锁  发送  按钮
  bool get isPreSend => _isPreSend.value;

  @override
  void onInit() {
    super.onInit();
    var map = Get.arguments;
    name = map['name'];
    connectServer(map['address'], map['port']);

    messageEditingController.addListener(() {
      _isPreSend.value = messageEditingController.text.isNotEmpty;
    });
  }

  @override
  void sendMessage(String message) {
    super.sendMessage(message);

    messageEditingController.clear();

    String time = formatDate(
        DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch),
        [HH, ':', nn, ':', ss],
        locale: const SimplifiedChineseDateLocale());

    _newMessage(name ?? id, message, time);
  }

  @override
  void onReceiveMessage(Map<String, dynamic> map) {
    super.onReceiveMessage(map);

    if (map.containsKey('nickname') &&
        map.containsKey('message') &&
        map.containsKey('timestamp')) {
      String name = map['nickname'];
      String message = map['message'];
      String time = formatDate(
          DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
          [HH, ':', nn, ':', ss],
          locale: const SimplifiedChineseDateLocale());

      _newMessage(name, message, time);
    }
  }

  void _newMessage(String name, String message, String time){
    Chat chat = Chat(name, message, time);
    chats.add(chat);

    _scrollToBottom();
  }

  _scrollToBottom() {
    // scrollController.animateTo(offset, duration: duration, curve: curve)
    Future.delayed(
        const Duration(milliseconds: 500),
        () =>
            scrollController.jumpTo(scrollController.position.maxScrollExtent));
  }
}
