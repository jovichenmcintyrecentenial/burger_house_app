import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:flutter/material.dart';

class MainButtonSmallWidget extends StatelessWidget {

  final String title;
  const MainButtonSmallWidget( this.title,{
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding:EdgeInsets.symmetric(horizontal: 8,vertical: 5),
        decoration: BoxDecoration(
            color:AppTheme.of(context).accentColor,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color:AppTheme.of(context).accentColor)
        ),
        child: AutoTextSizeWidget(title,color: Colors.white,fontSize: 10,),
      ),
    );
  }
}
