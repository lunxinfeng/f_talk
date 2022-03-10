import 'package:get/get.dart';

class Strings extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'zh_CN': {
        'login': '登录',
        'server_address': '服务器地址',
        'account': '用户名',
        'connect_fail': '连接服务器失败',
        'send': '发送',
      },
      'en_US': {}
    };
  }
}
