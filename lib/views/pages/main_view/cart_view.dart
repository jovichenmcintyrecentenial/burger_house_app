import 'package:burger_house/models/segue_model/order_segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/views/pages/main_view/providers/cart_view_provider.dart';
import 'package:burger_house/views/pages/main_view/providers/main_manager_view_provider.dart';
import 'package:burger_house/views/pages/order_confirmation/order_confirmation_view.dart';
import 'package:burger_house/views/widgets/app_bars/title_app_bar_widget.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/cart_item.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:burger_house/views/widgets/main_button_widget.dart';
import 'package:burger_house/views/widgets/stream_listner_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/cart.dart';
import '../../widgets/empty_list_widget/empty_cart_widget.dart';

class CartView extends StatelessWidget {
  CartView({
    super.key,
  });

  final _cart = ServiceLocator.locator<Cart>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartViewProvider(),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                child: AppTitleBar(
                  'My Cart',
                  actions: [
                    _CartTotalWidget(cart: _cart)
                  ],
                ),
              ),
              SizedBox(width:double.infinity,height:20),
              Consumer<CartViewProvider>(
                  builder: (context, provider, snapshot) {
                return provider.isLoading
                    ? Center(child: CircularProgressIndicator()):
                    _cart.items.length==0?
                        Expanded(child: EmptyCartWidget())
                    : ListView.builder(
                      padding: EdgeInsets.zero,
                         shrinkWrap: true,
                        itemCount: provider.getCartItems().length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              CartListItem(index),
                              SizedBox(
                                height: 16,
                              )
                            ],
                          );
                        },
                      );
              })
            ],
          ),
          StreamListeningWidget(
            streamName: Strings.cartItemDelete,
              builder: (context, snapshot) {
              final cart = ServiceLocator.locator<Cart>();
              return cart.getTotal() != 0?Positioned(
                  left: 0,
                  right: 0,
                  bottom: 130,
                  child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: MainButtonWidget(
                            'Checkout',
                            onTap: () =>
                                AppRoutes.navigate(
                                  context, OrderConfirmationView.routeName,
                                  GenericArgs<OrderSegueModel>(
                                      param: OrderSegueModel()),
                          ),
                          ))):SizedBox();
            }
          )
        ],
      ),
    );
  }
}


class _CartTotalWidget extends StatelessWidget {
  const _CartTotalWidget({
    required Cart cart,
  }) : _cart = cart;

  final Cart _cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20,top: 15),
        child: StreamListeningWidget(
          streamName: Strings.cartUpdate,
          builder: (context, snapshot) {
            return AutoTextSizeWidget(
              '\$' + _cart.getTotalFormatted(),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            );
          }
        ));
  }
}

