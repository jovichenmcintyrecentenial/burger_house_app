// @dart=2.12
import 'dart:async';

import '../utils/helper.dart';

enum NotificationAction{ appInitiated,updateMain,logout,appActive,appInactive,apiUnsupported,checkSettings }

class GlobalNotificationService {
  final _streamController = StreamController<NotificationAction>.broadcast();
  Stream<NotificationAction> get stream => _streamController.stream;

  var appInitialed = false;

  void trigger(NotificationAction notificationAction){
    if(appInitialed) {
      _streamController.add(notificationAction);
    }
  }

}