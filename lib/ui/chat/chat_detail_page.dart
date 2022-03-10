import 'package:f_talk/ui/chat/chat_detail_controller.dart';
import 'package:f_talk/util/regex.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ChatDetailController>(
        init: ChatDetailController(),
        builder: (c) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    controller: c.scrollController,
                    itemCount: c.chats.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${c.chats[index].name}    ${c.chats[index].time}',
                            softWrap: true,
                            style: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: _message(c.chats[index].message),
                          )
                        ],
                      );
                    }),
              ),
              const Divider(
                height: 1,
              ),
              Stack(
                children: [
                  TextField(
                    maxLines: 3,
                    controller: c.messageEditingController,
                  ),
                  Positioned(
                    right: 10.0,
                    bottom: 10.0,
                    child: ElevatedButton(
                        onPressed: c.isPreSend
                            ? () {
                                c.sendMessage(c.messageEditingController.text);
                              }
                            : null,
                        child: Text('send'.tr)),
                  ),
                ],
              )
            ],
          );
        });
  }

  Widget _message(String message) {
    var children = <Widget>[];
    message.split(" ").forEach((element) {
      if (isUrl(element)) {
        children.add(ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 250),
          child: Image.network(element),
        ));
      } else {
        children.add(Text(
          element,
          softWrap: true,
        ));
      }
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: children,
    );
  }
}
