import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmaster/controllers/controller.dart';
import 'package:taskmaster/screens/getstarted.dart';
import '../screens/homepage.dart';

import 'package:taskmaster/logics/storage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Storage st = Get.put(Storage());
    ControllerX cx = Get.put(ControllerX());
    return const GetMaterialApp(
      home: GetStarted(),
      debugShowCheckedModeBanner: false,
    );
  }
}
