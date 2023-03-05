import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/widgets/app_bars/title_app_bar_widget.dart';
import 'package:burger_house/views/widgets/order_card_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/title_header_widget.dart';

class OrdersView extends StatelessWidget {
  OrdersView({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTitleBar('My Orders'),
        Flexible(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Helper.getScaleWidthPercentage(context, 5)),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15,),
                    const TitleHeaderWidget(
                      'Active Orders',
                      fontSize: 24,
                      fontHeight: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height:10),
                    OrderCardWidget(),
                    const SizedBox(height: 15,),
                    const TitleHeaderWidget(
                      'Past Orders',
                      fontSize: 24,
                      fontHeight: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height:10),
                    OrderCardWidget(),
                    const SizedBox(height:10),
                    OrderCardWidget(),
                    const SizedBox(height:10),
                    OrderCardWidget(),
                    const SizedBox(height:10),
                    OrderCardWidget(),
                    const SizedBox(height:150),

                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



