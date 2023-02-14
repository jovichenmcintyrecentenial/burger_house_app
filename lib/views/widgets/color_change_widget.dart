import 'package:flutter/widgets.dart';

class ColorChangeWidget extends StatelessWidget{

  final Widget child;
  final Color? color;

  const ColorChangeWidget({Key? key,required this.color, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return color != null?ColorFiltered(
        colorFilter: ColorFilter.mode(
            color!, BlendMode.srcATop),
        child: child
    ):child;
  }

}