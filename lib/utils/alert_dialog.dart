import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



Widget _createAlertButton({title,onPress}){
  return  TextButton(
    onPressed: onPress,
    child: Text
      (title),
  );
}
void dismiss(BuildContext context){
  Navigator.pop(context);
}

void showAlertDialog(BuildContext context,{required List<AlertButton>? alertButtons,required String? title,required String? body}) {

  var buttons = <Widget>[];

  for (var button in alertButtons!) {
    buttons.add(_createAlertButton(title: button.title,onPress: button.onPress));
  }

  StatelessWidget alert;
  // set up the AlertDialog
  if(Platform.isIOS) {
    alert = CupertinoAlertDialog(
      title: Text(title!),
      content: Text(body!),
      actions: buttons,
    );
  }
  else{
    alert = AlertDialog(
      title: Text(title!),
      content: Text(body!),
      actions: buttons,
    );
  }

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

enum AlertButtonType{
  positive,
  negative,
}

class AlertButton{
  final String title;
  final dynamic onPress;
  final AlertButtonType? buttonType;

  AlertButton(this.title, {required this.onPress,required this.buttonType});

}
