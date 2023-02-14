import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:flutter/material.dart';

class TwoColorTextWidget extends StatelessWidget {

  final String firstText;
  final String secondText;
  final Function onTap;

  const TwoColorTextWidget(this.firstText,this.secondText, {
    super.key, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTap(),
      child: Container(
        height: 40,
        color: Colors.black.withOpacity(0.001),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            AutoTextSizeWidget(firstText),
            const SizedBox(width: 5,),
            AutoTextSizeWidget(secondText, color: AppTheme.of(context).accentColor,),
          ],
        ),
      ),
    );
  }
}