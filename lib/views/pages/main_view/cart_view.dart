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
                    itemCount: ServiceLocator.locator<Cart>().items.length,
                    itemBuilder: (BuildContext context, int index)  {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppTheme.of(context).primaryColorLight),
                        width: double.infinity,
                          child: Row(
                            children: [
                              GenericImagehandler(
                                Images.menu,
                                width: 50,
                                height: 50,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoTextSizeWidget(provider.cart.items[index].name!),
                                    AutoTextSizeWidget(provider.cart.items[index].type!),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoTextSizeWidget(
                                          '\$' +
                                              provider.cart.items[index].price!
                                                  .toString(),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        Transform.scale(
                                            scale: 0.8,
                                            child: StepperWidget(
                                                provider.cart.items[index])),
                                        GenericImagehandler(Images.cartButtonIcon)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
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



