import 'dart:async';


import '../../utils/helper.dart';

class HttpCustomClient {
  static Future<bool> getData<T>(
      {Future? initialData,
      Future<T>? future,required
      Function onError,required
      Function(T) onSuccess}) {

    if (initialData != null) {
      initialData.then((value) => onSuccess(value))
          .onError((error, stackTrace) {
        Helper.logger.e(error);
        onError(error);
      }).catchError((value) {
        Helper.logger.e(value);
        onError(value);
      });
    }

    if (future != null) {
      future.then((value) => onSuccess(value)).
      onError((error, stackTrace) {
        Helper.logger.e(error);
        onError(error);
      }).catchError((value) {
        Helper.logger.e(value);
        onError(value);
      });
    }
    return Future.value(true);
  }


}
