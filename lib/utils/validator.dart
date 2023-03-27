

import 'package:burger_house/utils/extensions/string_extension.dart';
import 'package:burger_house/utils/formatters/number_formtter.dart';
import 'package:burger_house/utils/helper.dart';

class Validator {

  static bool isXLong(String x,int maxLength){
    return x.isNumeric() && x.length >= maxLength;
  }

  static bool isNotEmpty(String text){
    return text.isNotEmpty;
  }

  static bool isNotNull(dynamic obj){
    if(obj == null){
      return false;
    }

    return true;
  }

  static bool isCCDateValid(dateText){
    if(!Validator.isXLong(NumberFormatter.clean(dateText),4)){
      throw(DisplayableException('Please enter a valid date'));
    }
    if(Validator.isXLong(NumberFormatter.clean(dateText),4)){
      String month = dateText.split('/')[0];
      String year = dateText.split('/')[1];
      if(month.isNumeric() && year.isNumeric()){
        var month = int.parse(dateText.split('/')[0]);
        if(month > 12){
          throw(DisplayableException('There is only 12 months in a year'));
        }
        var year = int.parse(dateText.split('/')[1]);
        var dateTime = DateTime(2000+year,month);
        var dataTimeNow = DateTime.now();
        if(!dataTimeNow.isBefore(dateTime)){
          throw(DisplayableException('Enter a date has not passed'));
        }
      }
    }
    return true;
  }

}