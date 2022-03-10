import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'res/strings.dart';
import 'ui/login/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'F_Talk',
      translations: Strings(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('zh', 'CN'),
      builder: (context, child){
        return Scaffold(
          body: child,
        );
      },
      home: const LoginPage(),
    );
  }
}
