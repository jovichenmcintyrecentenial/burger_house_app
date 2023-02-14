import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:flutter/material.dart';

class TitleHeaderWidget extends StatelessWidget {
  final String title;

  final double? fontSize;
  final double? fontHeight;
  const TitleHeaderWidget(this.title, {
    super.key, this.fontSize, this.fontHeight
  });

  @override
  Widget build(BuildContext context) {
    return AutoTextSizeWidget(
      title,
      height: fontHeight,
      fontSize: fontSize ?? 24,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );
  }
}
