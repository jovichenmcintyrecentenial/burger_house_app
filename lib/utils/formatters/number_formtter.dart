import 'package:intl/intl.dart';

import '../helper.dart';

enum FormatType { allowTrailingZero, noTrailingZero }

class NumberFormatter {
  static String clean(String text) {
    var cleanNumber = '';
    cleanNumber = RegExp(r'([0-9]|\.)')
        .allMatches(text)
        .map((m) => m[0])
        .toList()
        .join('');
    return cleanNumber;
  }

  static String format(
      {amount, locale, formatType = FormatType.noTrailingZero, dp = 2}) {
    var formattedAmount = amount;
    formattedAmount =
        NumberFormat.currency(decimalDigits: dp, locale: 'en_US', symbol: '')
            .format(double.parse(formattedAmount));
    final decimalIndex = formattedAmount.indexOf('.');

    final split = formattedAmount.split('.');

    if (formatType == FormatType.allowTrailingZero) {
    } else if (split.length > 1 && Helper.strToDouble(split[1]) > 0) {
      if (formatType == FormatType.noTrailingZero) {
        split[1] = split[1].replaceAll(RegExp(r'0*$'), '');
        formattedAmount = split[0] + '.' + split[1];
      }
    } else {
      formattedAmount = formattedAmount.substring(0, decimalIndex);
    }
    return formattedAmount;
  }

  static String formatPerChar({amount, key}) {
    var decimalPoint = '.';
    var numberSeparator = ',';

    if ((key != decimalPoint && !amount.contains(decimalPoint))) {
      amount = NumberFormatter.clean(amount);
    }

    //prevent double decimal
    if (key == decimalPoint && amount.contains(decimalPoint)) {
      return amount;
    } else if (amount == '0' && key == decimalPoint) {
      amount = '0$decimalPoint';
    } else if (key.toLowerCase() == 'x') {
      if (amount.length > 1) {
        amount = amount.substring(0, amount.length - 1);
      } else {
        amount = '0';
      }
    } else if (amount == '0' && amount != decimalPoint) {
      amount = key;
    } else {
      amount += key;
    }

    if (key != decimalPoint &&
        !amount.contains(decimalPoint) &&
        !amount.contains(numberSeparator)) {
      amount = NumberFormatter.format(amount: amount);
    }

    return amount;
  }
}
