import 'package:get/get.dart';

double get screenWidth {
  return Get.width;
}

double get screenHeight {
  return Get.height;
}

bool get isLand {
  return GetPlatform.isWindows;
}
