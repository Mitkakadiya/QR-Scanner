import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scanner/api/widget_text_field.dart';
import 'package:qr_scanner/common_button.dart';
import 'package:qr_scanner/qr_scanner_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool accountSetupLoader = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F5FA),
      appBar: AppBar(
        backgroundColor: Color(0xFFF1F5FA),
        title: Text(""),
      ),
      body: bodyView(),
      bottomNavigationBar: bottomButton(),
    );
  }

  bodyView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WidgetTextField(hintText: "Enter Your ID", textEditingController: idController),
        SizedBox(
          height: 20,
        ),
        WidgetTextField(hintText: "Enter Your Password", textEditingController: passwordController),
      ],
    ).paddingSymmetric(horizontal: 20);
  }

  Widget bottomButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: CommonButton(
          isEnable: true,
          isLoading: accountSetupLoader.value,
          onPressed: () async {
            print("clicked");
            Get.to(()=> QrScannerScreen());
          },
          title: 'Submit',
        ),
      ),
    );
  }
}
