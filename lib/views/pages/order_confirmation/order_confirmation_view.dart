import 'package:burger_house/models/address.dart';
import 'package:burger_house/models/segue_model/order_segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/pages/order_confirmation/bottom_sheets/address_bottom_sheet.dart';
import 'package:burger_house/views/pages/order_confirmation/bottom_sheets/payment_bottom_sheet.dart';
import 'package:burger_house/views/pages/order_confirmation/providers/order_confirmation_provider.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/edit_app_button.dart';
import 'package:burger_house/views/widgets/grid_view.dart';
import 'package:burger_house/views/widgets/horizontal_divider.dart';
import 'package:burger_house/views/widgets/main_button_widget.dart';
import 'package:burger_house/views/widgets/scaffolds/scaffold_main_app_bar.dart';
import 'package:burger_house/views/widgets/user_checkout_tile_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class OrderConfirmationView extends StatelessWidget {

  OrderConfirmationView({
    super.key,this.args,
  });

  final GenericArgs<OrderSegueModel>? args;
  static var routeName = "OrderConfirmationView";
  final List<String> images = [Images.slide1,Images.slide1,Images.slide1,Images.slide1,Images.slide1];

  @override
  Widget build(BuildContext context) {
    var scale =  0.7;
    return ChangeNotifierProvider<OrderConfirmationViewProvider> (
        create: (_) => OrderConfirmationViewProvider(),
        builder: (context, snapshot) {
          return ScaffoldMainAppBar(
            title: 'Checkout',
            actions: [EditAppBarButtonWidget()],
            backgroundColor: AppTheme.of(context).primaryColor,
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _HorizontalMenuItemList(scale: scale),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Consumer<OrderConfirmationViewProvider>(
                      builder: (context,provider, snapshot) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            UserCheckoutTitleItem(
                              image: Images.mapPinIcon,
                              title: 'Your Delivery Address',
                              data: provider.address==null?'Tap here to create an address':provider.address!.address!,
                              onTap: () async {
                                Helper.hideKeyboard(context);
                                var data = await showModalBottomSheet<Address>(
                                  context: context,
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (BuildContext context) {
                                    return AddressBottomSheet();
                                  },
                                );

                                if(data != null){
                                  provider.address = data;
                                }
                              }
                            ),
                            SizedBox(height: 15,),
                            UserCheckoutTitleItem(
                              onTap: () async {
                                Helper.hideKeyboard(context);
                                var data = await showModalBottomSheet<Address>(
                                  context: context,
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (BuildContext context) {
                                    return PaymentBottomSheet();
                                  },
                                );

                                if(data != null){
                                  provider.address = data;
                                }

                              },
                              image: Images.cardIcon,
                              title: 'Payment Method',
                              data: 'Tap here to add a payment method',
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                  SizedBox(height: 20,),
                  Consumer<OrderConfirmationViewProvider>(
                      builder: (context, provider, snapshot) {
                    return  provider.isLoading?Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(height: 100,),
                        CircularProgressIndicator(),
                      ],
                    ):Column(
                      children: [
                        buildFeeSection(context),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: MainButtonWidget('Place Order', onTap: (){},),
                        )
                      ],
                    );
                  }),

                ],
              ),
            ),
          );
        }
    );
  }

  Container buildFeeSection(BuildContext context) {

    var provider = Provider.of<OrderConfirmationViewProvider>(context);

    return Container(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _RowItemLabelData(label: 'Subtotal', data: '\$${provider.cart.getTotalFormatted()}'),
                    for(var fee in provider.orderDetails!.fees!)...[
                      _RowItemLabelData(label: fee.name!, data: '\$${fee.getPriceFormatted()}'),
                    ],
                    HorizontalDivider(color: Color(0xff3E3839),padding: EdgeInsets.symmetric(vertical: 10,)),
                    _RowItemLabelData(label: 'Total', data: '\$${provider.orderDetails!.getTotalFormatted()}',isBig: true,),
                  ],
                ),


              );
  }
}

class _RowItemLabelData extends StatelessWidget {
  final bool isBig;

  const _RowItemLabelData({
    required this.label,
    required this.data,
    this.isBig = false
  });

  final String label;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child:
          !isBig?AutoTextSizeWidget(label,color: Color(0xff7A7D86),):
          AutoTextSizeWidget(label,color: Color(0xff7A7D86),fontSize: 19,)),
          !isBig?AutoTextSizeWidget(data,):
          AutoTextSizeWidget(data,fontWeight: FontWeight.w700,fontSize: 19,),
        ],
      ),
    );
  }
}
class _HorizontalMenuItemList extends StatelessWidget {
  const _HorizontalMenuItemList({
    required this.scale,
  });

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220*scale,
      child: Consumer<OrderConfirmationViewProvider>(
        builder: (context,provider, snapshot) {
          var items = provider.getCartItems();
          return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: provider.getCartItems().length,
              itemBuilder: (BuildContext context, int index) {
              return GridItem2(items[index],scale: scale,index: index,);
            }
          );
        }
      ),
    );
  }
}
