// Dart imports:
import 'dart:math';


import 'package:burger_house/views/widgets/banner_widget.dart';
import 'package:overlay_support/overlay_support.dart';

import 'extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'formatters/number_formtter.dart';
import 'log_console_output.dart';


class Helper {
  static String logHistory = '';

  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      printTime: false,
    ),
    output: LogConsoleOutput(),
  );

  Helper._internal();

  static Logger get logger {
    return _logger;
  }


  static void showToast(String message,
      { isError = false,MessageType? messageType }) {

    showOverlayNotification((context) {
      return BannerMessageWidget(message: message,messageType: messageType,);
    });

  }


  static DateTime? convertToDate({String? dateStr, int? timestamp}) {
    try {
      //assume that is a unix time stamp
      if (timestamp != null) {
        return DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
      }

      //specific to what api returns
      var array = dateStr!.split('/');
      if (array.length > 1) {
        array = array.reversed.toList();

        var date = '';

        //concat for prep for parsing
        for (final arr in array) {
          date += arr;
        }

        //for date so that flutter can parse it from string
        var dateWithT = date.substring(0, 8) + 'T0000';

        //dateStr = 03/05/1990
        //date = 19900503T0000
        //look like the about after processing for parsing

        var dateTime = DateTime.parse(dateWithT);

        return dateTime;
      }
    } on Exception catch (exception) {
      logger.e(exception);
    }
    return null;
  }

  static double strToDouble(amt) {
    if (NumberFormatter.clean(amt).isNumeric()) {
      return double.parse(NumberFormatter.clean(amt));
    }
    return 0;
  }

  ///Accepts [number] in the format of 'x xxx-xxx-xxxx' and
  ///returns it in format of 'x (xxx) xxx-xxxx'
  static String reformatNumberWithParenthesis(String number) {
    return number.replaceFirst(' ', ' (').replaceFirst('-', ') ');
  }

  static double getScalePercentage(
    context,
    percent,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    double newSize = percent / 100 * ((screenHeight + screenWidth) / 2.0);

    return newSize;
  }

  static double getScaleWidthPercentage(
    context,
    double percent,
  ) {
    var screenWidth = MediaQuery.of(context).size.width;
    var newSize = percent / 100.0 * ((screenWidth));

    return newSize;
  }

  static double getScaleHeightPercentage(
    context,
    percent,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    double newSize = percent / 100 * ((screenHeight));

    return newSize;
  }


  static void showErrorException(codeBlock,{required BuildContext? context}) {
    try {
      codeBlock();
    } on Exception catch (exception) {
      if (exception is DisplayableException) {
        if(context!=null){
          hideKeyboard(context);
        }
        Helper.showToast((exception).errorMessage);

      }
      Helper.logger.e(exception);
    } catch (error) {
      Helper.logger.e(error);
    }
  }



  static int generateRandomNum() {
    var random = Random.secure();

    return random.nextInt(500000);
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static double appBarHeight(BuildContext context) {
    return (MediaQuery.of(context).padding.top + kToolbarHeight);
  }

  static double safeAreaBottomPadding(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double availableContentHeight(BuildContext context,{bool shrinkOnKeyboardVisible = false}){

      var height = screenHeight(context);
      if(hasSafeArea(context)){

        height = height -
            Helper.appBarHeight(context) -
            Helper.safeAreaBottomPadding(context) -
            (shrinkOnKeyboardVisible?MediaQuery.of(context).viewInsets.bottom:0.0)
        ;

      }

      return height;

  }



  static bool hasSafeArea(BuildContext context) {
    final paddings = MediaQuery.of(context).viewPadding;
    if(paddings.top>0){
      return true;
    }
    return false;
  }
}

class DisplayableException implements Exception {
  final String errorMessage;
  DisplayableException(this.errorMessage);
}
