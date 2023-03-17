import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:flutter/material.dart';
class EditAppBarButtonWidget extends StatelessWidget {
  const EditAppBarButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:()=>Navigator.pop(context),
      child: Container(
        color: Colors.red.withOpacity(0.001),
        padding: const EdgeInsets.only(right: 20,top:20),
        child: AutoTextSizeWidget('Edit'),
      ),
    );
  }
}
