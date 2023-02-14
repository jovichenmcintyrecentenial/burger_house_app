
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:flutter/material.dart';

class MainButtonWidget extends StatelessWidget {

  final String title;

  const MainButtonWidget(this.title, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      height:72,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.of(context).accentColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: AutoTextSizeWidget(
          title,
          color: Colors.white,
          fontFamily: FontFamily.poppins,
          fontWeight: FontWeight.w700,

        ),
      ),
    );
  }
}