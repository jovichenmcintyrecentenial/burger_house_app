import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import '../../services/service_locator.dart';

enum CleanType { full, allowSpaces }

class PhoneNumberFormatter {
  static String format({required String number}) {
    var phoneNumberLib = ServiceLocator.locator<FlutterLibphonenumber>();
    return phoneNumberLib.formatNumberSync(number);
  }

  static String cleanNumber(
      {required number, CleanType options = CleanType.allowSpaces}) {
    var regex = RegExp(r'(-|\(|\)|\+)');
    var replaced;
    if (options == CleanType.allowSpaces) {
      replaced = number.replaceAll(regex, ' ').replaceAll('  ', ' ');
    } else {
      replaced = number.replaceAll(regex, '').replaceAll(' ', '');
    }

    return replaced.toString().trim();
  }

  //put number in this function with templace eg. 5980402 and ___ ____ and get 598 0402
  static String? formatUsingTemplate({required String number, String? template}) {
    var formattedNumber = number;
    if (template != null) {
      var chars = number.split('');
      formattedNumber = template;
      for (var char in chars) {
        formattedNumber = formattedNumber.replaceFirst('_', char);
      }
      formattedNumber = formattedNumber.replaceAll('_', '');
    }
    return formattedNumber.trim();
  }

}
