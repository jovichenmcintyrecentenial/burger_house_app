import 'dart:async';

import 'package:burger_house/models/segue_model/segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:flutter/cupertino.dart';


class MainManagerProvider extends SegueNotifierViewProvider{
  static final StreamController<int> stream = StreamController<int>.broadcast();
  dynamic _subscriber;
  final PageController controller = PageController();

  MainManagerProvider(){

    _subscriber = stream.stream.listen((int action) {
      if (isDisposed) {
        _subscriber.cancel();
        return;
      }
      if(controller.hasClients) {
        controller.jumpToPage(action);
      }
      else{
        _subscriber.cancel();
      }

    });

  }

  @override
  bool isOk(BuildContext context, {GenericArgs? args}) {
    return true;
  }

  @override
  void updateSegueObject({GenericArgs? args}) {
  }

}