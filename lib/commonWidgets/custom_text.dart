import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String txtTitle;
  final TextStyle? style;
  final TextAlign align;
  final int? maxLine;
  final TextOverflow? textOverflow;
  final Widget? icon;
  final Function()? onTap;

  const CustomText({super.key, required this.txtTitle, this.style, this.align = TextAlign.start, this.maxLine, this.onTap, this.icon, this.textOverflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return onTap != null
        ? TextButton.icon(
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
        onPressed: onTap,
        icon: icon ?? const SizedBox(),
        label: Text(txtTitle, style: style, softWrap: true, textAlign: align, maxLines: maxLine, overflow: textOverflow))
        : Text(txtTitle, style: style, softWrap: true, textAlign: align, maxLines: maxLine, overflow: textOverflow);
  }
}