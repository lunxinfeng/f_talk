import 'package:flutter/material.dart';
import 'package:get/get.dart';

void startPage(Widget page, {dynamic arguments}) {
  Get.to(page, arguments: arguments);
}

void startPageAndRemovedAllBottom(Widget page, {dynamic arguments}) {
  Get.offAll(() => page, arguments: arguments);
}
