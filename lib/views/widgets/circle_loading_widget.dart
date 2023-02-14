import 'package:flutter/material.dart';

class CircleLoadingWidget extends StatelessWidget {
  final Color? backgroundColor;

  final double? height;
  final double? width;
  final double strokeWidth;

  const CircleLoadingWidget({
    Key? key, this.width,this.height,this.strokeWidth = 2,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        backgroundColor: backgroundColor,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
