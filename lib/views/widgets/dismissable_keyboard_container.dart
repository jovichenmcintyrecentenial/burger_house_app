
import 'package:flutter/material.dart';
import '../../utils/helper.dart';



class DismissableKeyboardContainer extends StatelessWidget {
  final Widget child;

  const DismissableKeyboardContainer({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return GestureDetector(
        onTap:() =>Helper.hideKeyboard(context),
        child: Container(color:Colors.black.withOpacity(0.001),child: child,));
  }

}