import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9+]'), '');

    if (newText.isNotEmpty && newText[0] == '+') {
      newText = '+${newText.replaceAll(RegExp(r'[^0-9]'), '')}';
    } else {
      newText = newText.replaceAll(RegExp(r'[^0-9]'), '');
    }

    if (newText.length > 1 && newText[0] == '+') {
      newText = '+${newText.substring(1)}';
    }

    // Calculate the new cursor position
    int baseOffset = newValue.selection.baseOffset;
    int extentOffset = newValue.selection.extentOffset;

    if (baseOffset > newText.length) {
      baseOffset = newText.length;
    }
    if (extentOffset > newText.length) {
      extentOffset = newText.length;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection(
        baseOffset: baseOffset,
        extentOffset: extentOffset,
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
