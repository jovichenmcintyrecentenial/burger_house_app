import 'package:burger_house/utils/formatters/number_formtter.dart';
import 'package:burger_house/utils/formatters/phone_number_formatter.dart';
import 'package:flutter/services.dart';

class CreditCardDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {

    var newText = newValue.text;
    var isBackspaced = false;

    isBackspaced = oldValue.text.length > newValue.text.length;
    var formattedNumber = newValue.text;
    if(!isBackspaced){



      var cleanText = NumberFormatter.clean(newText);


      cleanText = PhoneNumberFormatter.cleanNumber(number: cleanText);

       formattedNumber = PhoneNumberFormatter.formatUsingTemplate(number:cleanText,template:'__')!;
      if(cleanText.length >= 2){
        formattedNumber = PhoneNumberFormatter.formatUsingTemplate(number:cleanText,template:'__/__')!;
      }
    }
    else{

    }
    return TextEditingValue(
      text: formattedNumber,
      selection: TextSelection.collapsed(offset: formattedNumber.length),
    );
  }
}
