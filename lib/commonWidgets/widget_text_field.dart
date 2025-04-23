import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WidgetTextField extends StatefulWidget {
  final String? title;
  final String hintText;
  final bool isPassword;
  final Color? borderColor;
  final TextEditingController textEditingController;
  final Function? validationFunction;
  final int? maxLength;
  final Function? onSavedFunction;
  final Function? onFieldSubmit;
  final TextInputType? keyboardType;
  final Function? onTapFunction;
  final Function? onChangedFunction;
  final Function? toolTipFunction;
  final List<TextInputFormatter>? inputFormatter;
  final bool isEnabled;
  final bool isReadOnly;
  final bool isMandatory;
  final bool showToolTip;
  final int? errorMaxLines;
  final int? maxLine;
  final double? padding;
  final FocusNode? textFocusNode;
  final GlobalKey<FormFieldState>? fieldKey;
  final TextAlign align;
  final Widget? suffixIcon;
  final Widget? preFixIcon;
  final String? preFixText;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final BoxConstraints? suffixIconConstraints;
  final OutlineInputBorder? border;
  final OutlineInputBorder? focusBorder;
  final bool isShowTitle;
  final TextCapitalization textCapitalization;
  final Color? bgColor;
  final TextStyle? hintStyle;
  final UnderlineInputBorder? underlineInputBorder;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputAction textInputAction;
  final Widget? actionButton;

  const WidgetTextField({
    super.key,
    this.title,
    required this.hintText,
    this.isPassword = false,
    this.borderColor,
    required this.textEditingController,
    this.validationFunction,
    this.maxLength,
    this.onSavedFunction,
    this.onFieldSubmit,
    this.keyboardType,
    this.onTapFunction,
    this.onChangedFunction,
    this.toolTipFunction,
    this.inputFormatter,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.isMandatory = false,
    this.showToolTip = false,
    this.errorMaxLines,
    this.maxLine,
    this.padding,
    this.textFocusNode,
    this.fieldKey,
    this.align = TextAlign.start,
    this.suffixIcon,
    this.preFixIcon,
    this.preFixText,
    this.floatingLabelBehavior,
    this.suffixIconConstraints,
    this.border,
    this.focusBorder,
    this.isShowTitle = true,
    this.textCapitalization = TextCapitalization.none,
    this.bgColor,
    this.hintStyle,
    this.underlineInputBorder,
    this.contentPadding,
    this.textInputAction = TextInputAction.next,
    this.actionButton,
  });

  @override
  State<WidgetTextField> createState() => _WidgetTextFieldState();
}

class _WidgetTextFieldState extends State<WidgetTextField> {
  late bool passwordVisible;

  @override
  void initState() {
    super.initState();
    passwordVisible = !widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(12.0);
    OutlineInputBorder textFieldBorderStyle = OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFEAEEF2)),
      borderRadius: borderRadius,
    );
    OutlineInputBorder textFieldFocusBorder = OutlineInputBorder(
      borderRadius: borderRadius,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            widget.isShowTitle
                ? Text(
              widget.isMandatory ? "${widget.hintText} *" : widget.hintText,
              style: TextStyle(color: Color(0xFF1E2124), fontWeight: FontWeight.w500),
            ).paddingOnly(left: 2)
                : const SizedBox(),
            widget.actionButton ?? const SizedBox(),
          ],
        ),
        widget.isShowTitle ? const SizedBox(height: 8) : const SizedBox(),
        TextFormField(
          maxLength: widget.maxLength,
          enabled: widget.isEnabled,
          textAlign: widget.align,
          showCursor: !widget.isReadOnly,
          readOnly: widget.isReadOnly,
          textCapitalization: widget.textCapitalization,
          onTap: () => widget.onTapFunction?.call(),
          key: widget.fieldKey,
          focusNode: widget.textFocusNode,
          onChanged: (value) => widget.onChangedFunction?.call(value),
          validator: (value) => widget.validationFunction?.call(value),
          onSaved: (value) => widget.onSavedFunction?.call(value),
          onFieldSubmitted: (value) => widget.onFieldSubmit?.call(value),
          maxLines: widget.maxLine ?? 1,
          keyboardType: widget.keyboardType,
          controller: widget.textEditingController,
          cursorColor: const Color(0xFF1E2124),
          obscuringCharacter: "•",
          obscureText: !passwordVisible,
          style: TextStyle(color: widget.isEnabled ? Color(0xFF1E2124) : Color(0xFF717579)),
          inputFormatters: widget.inputFormatter,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            counterText: "",
            alignLabelWithHint: true,
            errorMaxLines: widget.errorMaxLines ?? 1,
            filled: true,
            floatingLabelBehavior: widget.floatingLabelBehavior,
            fillColor: widget.bgColor ?? Colors.white,
            contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(horizontal: widget.padding ?? 16, vertical: 18),
            focusedBorder: widget.isEnabled ? widget.focusBorder ?? textFieldFocusBorder : widget.border ?? textFieldBorderStyle,
            disabledBorder: widget.border ?? textFieldBorderStyle,
            enabledBorder: widget.border ?? textFieldBorderStyle,
            errorBorder: widget.border ?? textFieldBorderStyle,
            border: const OutlineInputBorder(),
            focusedErrorBorder: widget.border ?? textFieldBorderStyle,
            hintText: widget.hintText,
            prefixIcon: widget.preFixIcon,
            prefixText: widget.preFixText,
            suffixIconConstraints: widget.suffixIconConstraints,
            suffixIcon: widget.isPassword
                ? GestureDetector(
              onTap: () => setState(() => passwordVisible = !passwordVisible),
              child: Image.asset(
                passwordVisible ? "assets/icon/visibility_rounded.png" : "assets/icon/visibility_off.png",
                scale: 4,
              ),
            )
                : widget.suffixIcon,
          ),
        ),
      ],
    );
  }
}