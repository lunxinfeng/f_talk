import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:f_talk/util/log.dart';

class Message {
  String message = "";
  String? name;

  String toJson(){
    Map map = {};
    map['message'] = message;
    if(name != null){
      map['nickname'] = name;
    }
    return '${json.encode(map)}\r\n';
  }

  @override
  String toString() {
    return 'Message{message: $message}';
  }
}

class SocketManager {
  static Socket? _socket;
  static bool _isConnect = false;

  static connect(
    String address,
    int port, {
    Function? connectSuccess,
    Function? connectFail,
    Function(Message)? receive,
  }) async {
    Log.i("start connect server...: $address:$port");
    Socket.connect(address, port).then((value) {
      Log.i("connect success");
      _isConnect = true;
      _socket = value;

      List<int> temp = List.empty(growable: true);
      _socket?.listen((data) {
        _onData(data, temp, receive);
      }, onError: _error, onDone: _done, cancelOnError: false);

      _heart();

      connectSuccess?.call();
    }).onError((error, stackTrace) {
      Log.e("connect error", error, stackTrace);
      connectFail?.call();
    }).whenComplete(() {
      Log.i("connect complete");
    }).timeout(const Duration(seconds: 5));
  }

  static sendMessage(Message message) async {
    if (!_isConnect) return;
    _socket?.add(_messageToUnit8List(message));
  }

  static close() {
    Log.i('close');
    _socket?.close();
  }

  static _heart() {
    //todo
  }

  static _error(error, StackTrace trace) {
    Log.e("_Error", error, trace);
  }

  static _done() {
    Log.i('_Done');
    _socket?.close();
    _socket?.destroy();
    _socket = null;
    _isConnect = false;
  }

  static _onData(Uint8List data, List<int> temp, Function(Message)? receive) {
    List<int> separator() {
      var endFlag = utf8.encode("\r\n");
      var list = List<int>.empty(growable: true);
      var i = data.indexOf(endFlag[0]);
      while (i >= 0 && i < data.length - 1) {
        if (data[i + 1] == endFlag[1]) {
          list.add(i);
        }
        i = data.indexOf(endFlag[0], i + 1);
      }
      return list;
    }

    var list = separator();
    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        var start = i <= 0 ? 0 : list[i - 1] + 2;
        var end = list[i];
        temp.addAll(data.sublist(start, end));

        receive?.call(Message()..message = utf8.decode(temp));

        temp.clear();
      }
      temp.addAll(data.sublist(list.last + 2));
    } else {
      Log.w("半包消息");
      temp.addAll(data);
    }
  }

  static List<int> _messageToUnit8List(Message message) {
    List<int> data = List.empty(growable: true);
    data.addAll(utf8.encode(message.toJson()));
    return data;
  }
}
