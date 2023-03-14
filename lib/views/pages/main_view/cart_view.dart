import 'package:burger_house/models/cart.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/pages/main_view/providers/cart_view_provider.dart';
import 'package:burger_house/views/widgets/app_bars/title_app_bar_widget.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:burger_house/views/widgets/menu_item_bottom_sheet.dart';
import 'package:burger_house/views/widgets/order_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../widgets/title_header_widget.dart';

class CartView extends StatelessWidget {
  CartView({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>CartViewProvider(),
      child: Column(
        children: [
          AppTitleBar('My Cart'),
          Expanded(
            child: Consumer<CartViewProvider>(
                builder: (context,provider, snapshot) {
                  return provider.isLoading?
                  Center(child: CircularProgressIndicator()):
                  ListView.builder(
                    itemCount: provider.getCartItems().length,
                    itemBuilder: (BuildContext context, int index)  {
                      return Column(
                        children: [
                          CartListItem(index),
                          SizedBox(height: 20,)
                        ],
                      );
                    },
                  );
                }
            ),
          )

        ],
      ),
    );
  }
}

class CartListItem extends StatelessWidget {
  final int index;

  const CartListItem( this.index,{
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartViewProvider>(context);
    var menuItem = provider.getCartItems()[index];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,),
      padding: EdgeInsets.only(right: 20,left: 15,top: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme.of(context).primaryColorLight),
      width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GenericImagehandler(
              menuItem.imageUrl,
              width: 120,
              height: 120,
            ),
            SizedBox(width: 5,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoTextSizeWidget(menuItem.name!,fontSize: 20,fontWeight: FontWeight.w700,),
                  AutoTextSizeWidget(menuItem.type!,height:1.2,fontSize: 15,fontWeight: FontWeight.w500, color: Color(0xff7A7D86),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoTextSizeWidget(
                        '\$' +
                            menuItem.price!
                                .toString(),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      Transform.scale(
                          scale: 0.8,
                          child: StepperWidget(
                              menuItem)),
                      GenericImagehandler(Images.cartButtonIcon)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
  }
}



