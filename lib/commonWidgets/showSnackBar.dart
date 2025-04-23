import 'package:flutter/material.dart';
import 'package:qr_scanner/utility/colors.dart';
import 'package:qr_scanner/utility/text_style.dart';

import '../api/api_config.dart';
import 'custom_text.dart';

class CustomSnackbarWidget extends StatelessWidget {
  final String title;
  final String message;

  const CustomSnackbarWidget({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSuccess = title == ApiConfig.success;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isSuccess ? color4AA900 : colorB3261E,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.15),
            blurRadius: 20,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorFFFFFF,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // You can uncomment and provide asset path
                // Image.asset(isSuccess ? 'assets/icon/success.png' : 'assets/icon/error.png', scale: 4),
                const SizedBox(width: 5),
                CustomText(
                  txtTitle: title,
                  style: isSuccess ? color4AA900w60016 : colorB3261Ew60016,
                ),
              ],
            ),
            const SizedBox(height: 15),
            CustomText(
              txtTitle: message,
              style: color4AA900w50014.copyWith(
                color: isSuccess ? color4AA900 : colorB3261E,
              ),
              textOverflow: TextOverflow.visible,
            ),
          ],
        ),
      ),
    );
  }
}
