import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      // Allow the user to input a dollar sign at the beginning
      return TextEditingValue(
        text: '\$${newValue.text}',
        selection: TextSelection.collapsed(offset: 1),
      );
    }

    String cleanedValue = newValue.text.replaceAll(RegExp(r'[^\d.,]'), '');

    // Allow both ',' and '.' as separators
    cleanedValue = cleanedValue.replaceAll(RegExp(r','), '');

    // Split the cleaned value by either '.' or ','
    List<String> parts = cleanedValue.split(RegExp(r'[.,]'));

    if (parts.length > 2) {
      return oldValue;
    }

    String formattedValue = parts[0];
    if (parts.length == 2) {
      formattedValue += '.' + parts[1];
    }

    formattedValue = formattedValue.replaceAll('\$', '');

    return TextEditingValue(
      text: '\$' + formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length + 1),
    );
  }

  double getNumericValue(String formattedText) {
    final numericPart = formattedText.replaceAll('\$', '');
    return double.parse(numericPart);
  }
}
