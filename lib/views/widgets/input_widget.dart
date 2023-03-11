
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {

  final String title;
  final bool obscureText;
  final bool autoFocus;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  final Function(String text)? onChangeText;
  const InputWidget({
    super.key, required this.title,
    this.keyboardType,
      this.obscureText = false,
      this.controller,
      this.onChangeText,
      this.autoFocus = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color:AppTheme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child:  Center(
        child:  TextField(
          keyboardType:keyboardType,
          obscureText: obscureText,
          controller: controller,
          onChanged: onChangeText,
          autofocus: autoFocus,
          style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              label: AutoTextSizeWidget(
                title,
                fontWeight: FontWeight.w500,
                color: const Color(0xff7A7D86),
              ),

              border: InputBorder.none
          ),
        ),
      ),
    );
  }
}
