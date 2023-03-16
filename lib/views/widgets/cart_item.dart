import 'package:burger_house/data/models/response_model/menu_item.dart';
import 'package:burger_house/models/cart.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/views/pages/main_view/providers/cart_view_provider.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:burger_house/views/widgets/menu_item_bottom_sheet.dart';
import 'package:burger_house/views/widgets/stream_listner_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartListItem extends StatelessWidget {
  final int index;

  const CartListItem(
      this.index, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartViewProvider>(context);
    var menuItem = provider.getCartItems()[index];
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      padding: EdgeInsets.only(right: 20, left: 15, top: 12),
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
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoTextSizeWidget(
                  menuItem.name!,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                AutoTextSizeWidget(
                  menuItem.type!,
                  height: 1.2,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff7A7D86),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: AutoTextSizeWidget(
                        '\$' + menuItem.price!.toString(),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Transform.scale(
                        scale: 0.8,
                        child: StepperWidget(
                          key:GlobalKey(),
                          menuItem,
                          smallerFonts: true,
                        )),
                    _DeleteItemButton(menuItem)
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

class _DeleteItemButton extends StatelessWidget {
  final MenuItem menuItem;

  const _DeleteItemButton(this.menuItem);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        final cart = ServiceLocator.locator<Cart>();
        cart.clearCartOfMenuItem(menuItem);
        StreamListeningWidget.trigger(StreamObject(name: Strings.cartUpdate, object: true));
        StreamListeningWidget.trigger(StreamObject(name: Strings.cartItemDelete, object: true));
      },
      child: Container(
          height: 40,
          width: 35,
          color: Colors.red.withOpacity(0.001),
          child: Center(
            child: GenericImagehandler(
              Images.trashIcon,
              width: 20,
              height: 20,
            ),
          )),
    );
  }
}
