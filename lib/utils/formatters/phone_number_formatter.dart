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
    String replaced;
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

      RegExp pattern = RegExp(r'\d');
      int index = formattedNumber.lastIndexOf(pattern);
      if(index != -1){
        formattedNumber = formattedNumber.substring(0,index+1);
      }
      else if(number.length == 0){
        formattedNumber = "";
      }

    }
    return formattedNumber.trim();
  }

}
