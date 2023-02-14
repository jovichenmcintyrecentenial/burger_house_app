import 'package:flutter/services.dart';

import 'number_formtter.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  var decimalPoint = '.';
  var numberSeparator = ',';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var amount = oldValue.text;
    var key = newValue.text;

    if (NumberFormatter.clean(oldValue.text).length >
        NumberFormatter.clean(newValue.text).length) {
      key = 'x';
    } else {
      key = newValue.text.substring(oldValue.text.length);
    }

    amount = NumberFormatter.formatPerChar(amount: amount, key: key);

    return TextEditingValue(
      text: amount,
      selection: TextSelection.collapsed(offset: amount.length),
    );
  }
}
