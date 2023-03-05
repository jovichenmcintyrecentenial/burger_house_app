import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/horizontal_divider.dart';
import 'package:burger_house/views/widgets/main_button_small_widget.dart';
import 'package:flutter/material.dart';

class OrderCardWidget extends StatelessWidget {
  final bool isActive;

  const OrderCardWidget({
    this.isActive = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      decoration: BoxDecoration(
          color:AppTheme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(20),
          border: isActive?Border.all(color:AppTheme.of(context).accentColor):null
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildGreyFonts('Order number: 3328'),
          SizedBox(height: 5,),
          Row(
            children: [
              Expanded(child: buildWhiteFonts('January 12, 10:32 AM')),
              buildWhiteFonts('\$50.00'),
            ],
          ),
          SizedBox(height: 14,),
          HorizontalDivider(),
          SizedBox(height: 12,),
          buildGreyFonts('3 Items'),
          buildGreyFonts('HOUSE Double and 2 more items ...'),
          SizedBox(height: 15,),
          Row(
            children: [
              MainButtonSmallWidget('View Receipt'),
              SizedBox(width: 10,),
              MainButtonSmallWidget('Track Order')

            ],
          )

        ],),

    );
  }

  AutoTextSizeWidget buildGreyFonts(String text, {double? fontSize}) {
    return AutoTextSizeWidget(
      text,
      color: Color(0xff7A7D86),
      fontSize: fontSize??13,
    );
  }

  AutoTextSizeWidget buildWhiteFonts(String text) {
    return AutoTextSizeWidget(
      text,
      color: Colors.white,
      fontSize: 15,fontWeight: FontWeight.w700,
    );
  }
}
