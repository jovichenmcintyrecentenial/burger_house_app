
import 'package:flutter/material.dart';


BoxDecoration decorateHideBorder(color){
  return  BoxDecoration(
    color:color,
    border: Border.all(width: 0, color: color,style: BorderStyle.none),
  );
}

ButtonStyle textButtonStyleNoPaddingStyle(){
  return  TextButton.styleFrom(
      padding: EdgeInsets.zero);
}

BoxDecoration buildCurveTop(color) {
  return BoxDecoration(
    color: color,
    border: Border.all(color: Colors.transparent),
    borderRadius: const BorderRadius.only(
        topRight: Radius.circular(22.0),
        topLeft: Radius.circular(22.0)),
  );
}

