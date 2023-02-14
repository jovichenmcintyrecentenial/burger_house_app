import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:flutter/material.dart';

class SubTitleWidget extends StatelessWidget {
  final String subtitle;

  final FontWeight? fontWeight;

  const SubTitleWidget(this.subtitle, {
    super.key, this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return AutoTextSizeWidget(
      subtitle,
      color: const Color(0xff7A7D86),
      fontSize: 16,
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }
}