import 'package:burger_house/data/models/response_model/order_response_model.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/extensions/date_time_extension.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/horizontal_divider.dart';
import 'package:burger_house/views/widgets/main_button_small_widget.dart';
import 'package:flutter/material.dart';

class OrderCardWidget extends StatelessWidget {
  final bool isActive;
  final Order order;

  const OrderCardWidget(this.order, {
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
          buildGreyFonts('Order number: ${order.id?.substring(5,9).toUpperCase()}'),
          SizedBox(height: 5,),
          Row(
            children: [
              Expanded(child: buildWhiteFonts(order.createdAt!.getFormattedDateLocalWords())),
              buildWhiteFonts('\$${order.getTotalFormatted()}'),
            ],
          ),
          SizedBox(height: 14,),
          HorizontalDivider(),
          SizedBox(height: 12,),
          buildGreyFonts('${order.menuItems?.length} Items'),
          buildGreyFontsEllipsis(order.getOrderItemsName()),
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

  Text buildGreyFontsEllipsis(String text, {double? fontSize}) {
    return Text(
      text,
      style: TextStyle(color: Color(0xff7A7D86),
        fontSize: fontSize??13,
      fontWeight: FontWeight.w500),
      overflow: TextOverflow.ellipsis,

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
