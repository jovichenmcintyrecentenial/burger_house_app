import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:flutter/material.dart';

class TitleHeaderWidget extends StatelessWidget {
  final String title;
  const TitleHeaderWidget(this.title, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  AutoTextSizeWidget(title,fontSize: 24,fontWeight: FontWeight.w700,color: Colors.white,);
  }
}
