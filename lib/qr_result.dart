import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QrResult extends StatelessWidget {
  Barcode? result;

  QrResult({super.key, this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            result != null
                ? Text("Data: ${result!.code}")
                : Text("Something went wrong")
          ],
        ),
      ),
    );
  }
}
