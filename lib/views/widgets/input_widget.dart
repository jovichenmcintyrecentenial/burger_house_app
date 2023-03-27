
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatelessWidget {

  final String title;
  final bool obscureText;
  final bool autoFocus;
  final TextInputType? keyboardType;
  final Color? color;
  final double? height;
  final TextEditingController? controller;

  final Function(String text)? onChangeText;
  final TextInputFormatter? inputFormatter;

  final double? fontSize;

  const InputWidget({
    super.key, required this.title,
    this.keyboardType,
      this.obscureText = false,
      this.inputFormatter,
      this.controller,
      this.color,
      this.height,
      this.onChangeText,
      this.autoFocus = false, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 72,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color:color ?? AppTheme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child:  Center(
        child:  TextField(
          keyboardType:keyboardType,
          obscureText: obscureText,
          controller: controller,
          onChanged: onChangeText,
          autofocus: autoFocus,
          inputFormatters: inputFormatter != null ? [inputFormatter!] : null,
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: fontSize),
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
