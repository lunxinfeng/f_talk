// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:f_talk/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // // Build our app and trigger a frame.
    // await tester.pumpWidget(const MyApp());
    //
    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);
    //
    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);

    List<int> data = [1, 2, 3, 13, 10, 4, 5, 6, 13, 10, 13, 10,1,1, 13, 10];

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
    print(list);
  });


}
