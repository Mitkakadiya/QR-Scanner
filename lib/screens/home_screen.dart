import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scanner/screens/qr_scanner_screen.dart';
import 'package:qr_scanner/utility/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorDF1827,
        title: Text("Pravesh",style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: colorDF1827,
                    borderRadius: BorderRadius.circular(4)),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.to(() => QrScreen());
                  },
                  child: Text("Scan QR",style: TextStyle(
                    color: Colors.white
                  ),).paddingSymmetric(vertical: 4,horizontal: 8),
                ))
          ],
        ),
      ),
    );
  }
}
