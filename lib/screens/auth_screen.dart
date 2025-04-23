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
        floatingActionButton: bottomButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  bodyView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/icon/app_logo.webp',
                height: 80,
              ),
            ),
            const SizedBox(width: 8),
            Obx(() => Row(
              children: List.generate(HomeController.to.pravesh.length, (index) {
                return AnimatedOpacity(
                  opacity: HomeController.to.isVisible[index] ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    HomeController.to.pravesh[index],
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                );
              }),
            )),
          ],
        ),
        SizedBox(height: 70,),
        WidgetTextField(
          textInputAction: TextInputAction.done,
          hintText: "Enter Your Mobile No.",
          textEditingController: mobileNumberController,
          maxLine: 1,
          keyboardType: TextInputType.number,
          maxLength: 10,
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
              Get.off(() => HomeScreen());
            });
          },
          title: 'Submit',
        ),
      ),
    );
  }
}
