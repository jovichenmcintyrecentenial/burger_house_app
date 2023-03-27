import 'package:burger_house/utils/formatters/number_formtter.dart';
import 'package:burger_house/utils/formatters/phone_number_formatter.dart';
import 'package:flutter/services.dart';

class CreditCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {

    var cleanText = NumberFormatter.clean(newValue.text);
    cleanText = PhoneNumberFormatter.cleanNumber(number: cleanText);
    var formattedNumber = PhoneNumberFormatter.formatUsingTemplate(number:cleanText,template:'____-____-____-____');

    return TextEditingValue(
      text: formattedNumber!,
      selection: TextSelection.collapsed(offset: formattedNumber.length),
    );
  }
}
