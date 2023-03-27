import 'package:burger_house/utils/formatters/number_formtter.dart';
import 'package:flutter/services.dart';

import 'phone_number_formatter.dart';

class CreditCardCVVFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {

    var cleanText = NumberFormatter.clean(newValue.text);
    cleanText = PhoneNumberFormatter.cleanNumber(number: cleanText);
    var formattedNumber = PhoneNumberFormatter.formatUsingTemplate(number:cleanText,template:'___');

    return TextEditingValue(
      text: formattedNumber!,
      selection: TextSelection.collapsed(offset: formattedNumber.length),
    );
  }
}
