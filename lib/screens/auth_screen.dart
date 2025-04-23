import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scanner/controller/homeController.dart';
import 'package:qr_scanner/commonWidgets/widget_text_field.dart';
import 'package:qr_scanner/commonWidgets/common_button.dart';
import 'package:qr_scanner/screens/home_screen.dart';
import 'package:qr_scanner/screens/qr_scanner_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Color(0xFFF1F5FA),
        appBar: AppBar(
          backgroundColor: Color(0xFFF1F5FA),
          title: Text(""),
        ),
        body: bodyView(),
        bottomNavigationBar: bottomButton(),
      ),
    );
  }

  bodyView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WidgetTextField(
          textInputAction: TextInputAction.done,
          hintText: "Enter Your Mobile No.",
          textEditingController: mobileNumberController,
          maxLine: 1,
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: 20,
        ),
        // WidgetTextField(hintText: "Enter Your Password", textEditingController: passwordController),
      ],
    ).paddingSymmetric(horizontal: 20);
  }

  Widget bottomButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: CommonButton(
          isEnable: true,
          isLoading: HomeController.to.loginLoader.value,
          onPressed: () async {
            print("object");
            HomeController.to.loginUser({"phone": mobileNumberController.text}, callBack: () {
              Get.to(() => HomeScreen());
            });
          },
          title: 'Submit',
        ),
      ),
    );
  }
}
