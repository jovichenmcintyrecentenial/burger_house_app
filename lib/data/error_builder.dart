import 'dart:async';

import 'package:dio/dio.dart';

import '../utils/helper.dart';

class ErrorFactory {
  //these will be removed temporary this is just to keep name similar when
  // localization is completed
  static const tooManyRequest =
      'Too many login request, please try again later.';
  static const loginMobileNumberUnkown =
      'The mobile number you entered is not registered';
  static const unableToCompleteTask =
      'Unable to complete task, please try again.';
  static const networkError = 'Please ensure you have internet connection';

  static bool containsError({error,contains}){
    if (error is DioError) {
      final dioError = error;
      if (_contains(dioError, [contains])) {
        return true;
      }
    }
    return false;
  }

  static FutureOr<Null> showError(Object? error,StackTrace ){
      Helper.showToast(buildMessage(error));
      return null;
  }

  //server return none user friendly message so app has to interpret here and show proper translation as well
  static String buildMessage( error, {String? api}) {
    if (error is DioError) {
      final dioError = error;
      if(dioError.response?.data != null && dioError.response?.data['message'] != null){
        var message = dioError.response?.data['message'];
        if(message != null){
          return message;
        }
      }
    } else {
      Helper.logger.e(error);
    }


    return unableToCompleteTask;
  }

  static bool _contains(DioError error, List<String> strings) {
    var isFound = false;
    if (error.response != null) {
      for (var string in strings) {
        if (error.response
            .toString()
            .toLowerCase()
            .contains(string.toString().toLowerCase())) {
          isFound = true;
        }
      }
    }
    return isFound;
  }
}

class ErrorStrings {
  static const otpExpired = 'otp request has expired';
  static const emailAlreadyInUse = ' is already in use.';
  static const emailAlreadyInUseByThisUser = ' was already added for this user.';
  static const userAlreadyAddNumber = 'Mobile number was already added by user.';
  static const tooMany = 'Too Many';
  static const accountWasFound = 'account was found';
  static const timeOut = 'time out';
  static const socket = 'socket';
  static const invitationCodeIsIncorrect = 'invalid code';
  static const mobileNumberAlreadyInUser = 'Mobile number is already in use.';
  static const codeIsInvalid = 'code is invalid.';
  static const otpIsIncorrect = 'otp is incorrect';
  static const mobileNumberInUse = 'The mobile number ';
  static const verificationCode = 'Verification code is invalid.';
}
