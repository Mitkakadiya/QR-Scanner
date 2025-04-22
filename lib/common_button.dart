import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'custom_text.dart';

class CommonButton extends StatefulWidget {
  final String title;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? spinColor;
  final TextStyle? style;
  final Decoration? decoration;
  final double? width;
  final double? height;
  final bool isLoading;
  final bool? isEnable;

  const CommonButton(
      {super.key,
        required this.isLoading,
        required this.title,
        this.icon,
        this.spinColor,
        this.isEnable,
        this.onPressed,
        this.width,
        this.height,
        this.padding,
        this.margin,
        this.decoration,
        this.style,
        this.color});

  @override
  State<CommonButton> createState() => _CommonButtonState();
}
class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.isEnable == false
              ? () {}
              : widget.isLoading
              ? () {}
              : widget.onPressed,
          child: Container(
            width: widget.width ?? double.infinity,
            height: widget.height ?? 54,
            decoration: widget.decoration ??
                BoxDecoration(
                  color: widget.color ?? Color(0xFF000000),
                ),
            child: Container(
              width: widget.width ?? double.infinity,
              height: widget.height ?? 54,
              decoration: BoxDecoration(color: widget.isEnable == false ? Colors.white.withOpacity(0.5) : null),
              margin: widget.margin ?? EdgeInsets.zero,
              padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: widget.isLoading
                  ? SizedBox(height: 20, child: SpinKitThreeBounce(color: widget.spinColor ?? Color(0xFFFFFFFF), size: 30.0))
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.icon == null
                      ? Expanded(
                    child: Center(
                      child: CustomText(
                        align: TextAlign.center,
                        txtTitle: widget.title.toUpperCase(),
                        style: widget.style ??
                            colorFFFFFFw60016.copyWith(
                              overflow: TextOverflow.ellipsis,
                            ),
                      ),
                    ),
                  )
                      : Expanded(
                    child: Center(
                      child: CustomText(
                        onTap: widget.onPressed,
                        icon: widget.icon ?? const SizedBox(),
                        align: TextAlign.center,
                        txtTitle: widget.title.toUpperCase(),
                        style: widget.style ??
                            colorFFFFFFw60016.copyWith(
                              overflow: TextOverflow.ellipsis,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  TextStyle colorFFFFFFw60016 = const TextStyle(height:1.2,color: Color(0xFFFFFFFF),fontSize: 16,fontWeight: FontWeight.w600,fontFamily: "WorkSans");

}
