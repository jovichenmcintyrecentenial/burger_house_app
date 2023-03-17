
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:flutter/material.dart';

class MainButtonWidget extends StatelessWidget {

  final String title;

  final Function onTap;

  final bool hasShadow;

  const MainButtonWidget(this.title, {
    super.key, required this.onTap,
    this.hasShadow = true
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTap(),
      child: Container(

        height:72,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.of(context).accentColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: hasShadow?[ BoxShadow(
            color: Colors.black.withOpacity(0.2), // background color
            spreadRadius: 3,
            blurRadius: 4.0,
            offset: -Offset(-1,-5),

          ),]:[],
        ),
        child: Center(
          child: AutoTextSizeWidget(
            title,
            color: Colors.white,
            fontFamily: FontFamily.poppins,
            fontWeight: FontWeight.w700,
            fontSize: 20,

          ),
        ),
      ),
    );
  }
}



class MediumButtonWidget extends StatelessWidget {

  final String title;

  final Function onTap;

  final bool hasShadow;
  final bool isSecondaryButton;

  const MediumButtonWidget(this.title, {
    super.key, required this.onTap,
    this.isSecondaryButton = false,
    this.hasShadow = true
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTap(),
      child: Container(

        height:50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSecondaryButton?Color(0xff372F2C):AppTheme.of(context).accentColor2,
          borderRadius: BorderRadius.circular(15),
          boxShadow: hasShadow?[ BoxShadow(
            color: Colors.black.withOpacity(0.2), // background color
            spreadRadius: 3,
            blurRadius: 4.0,
            offset: -Offset(-1,-5),

          ),]:[],
          border: isSecondaryButton?Border.all(color: Color(0xffB27227)):null
        ),
        child: Center(
          child: AutoTextSizeWidget(
            title,
            color: isSecondaryButton?Color(0xffDF933B):Colors.white,
            fontFamily: FontFamily.poppins,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}