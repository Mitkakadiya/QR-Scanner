import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scanner/app_binding.dart';
import 'package:qr_scanner/controller/homeController.dart';
import 'package:qr_scanner/model/login_data_model.dart';
import 'package:qr_scanner/screens/auth_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_scanner/screens/home_screen.dart';


final GetStorage getPreference = GetStorage();

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (LoginDataModel.fromJson(getObject("loginModel") ?? {}).user?.phone ?? "").isEmpty ? const AuthScreen() : HomeScreen(),
    );
  }
}

