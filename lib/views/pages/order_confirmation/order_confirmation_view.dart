import 'package:burger_house/models/segue_model/order_segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/constants.dart';
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
          var label = 'Delivery Fee';
          var data = 'heelle';
          return ScaffoldMainAppBar(
            title: 'My Order',
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UserCheckoutTitleItem(
                          image: Images.mapPinIcon,
                          title: 'Your Delivery Address',
                          data: 'Tap here to select an address',
                        ),
                        SizedBox(height: 15,),
                        UserCheckoutTitleItem(
                          image: Images.cardIcon,
                          title: 'Payment Method',
                          data: 'Tap here to select an address',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  buildFeeSection(context, label, data),
                  SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MainButtonWidget('Place Order', onTap: (){},),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  Container buildFeeSection(BuildContext context, String label, String data) {
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
                    _RowItemLabelData(label: 'Subtotal', data: '\$10.99'),
                    _RowItemLabelData(label: label, data: '\$2.99'),
                    _RowItemLabelData(label: 'Service Fee', data: '\$5.99'),
                    _RowItemLabelData(label: 'Tax',data: '\$3.99'),
                    HorizontalDivider(color: Color(0xff3E3839),padding: EdgeInsets.symmetric(vertical: 10,)),
                    _RowItemLabelData(label: 'Total', data: '\$12.99',isBig: true,),
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
