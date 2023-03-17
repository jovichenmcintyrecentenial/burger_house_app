import 'package:burger_house/models/segue_model/order_segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/views/pages/order_confirmation/providers/order_confirmation_provider.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:burger_house/views/widgets/grid_view.dart';
import 'package:burger_house/views/widgets/scaffolds/scaffold_main_app_bar.dart';
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
            title: 'My Order',
            actions: [EditButtonWidget()],
            backgroundColor: AppTheme.of(context).primaryColor,
            body: Column(
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

              ],
            ),
          );
        }
    );
  }
}

class UserCheckoutTitleItem extends StatelessWidget {

  final String data ;
  final String title;

  final String image;

  const UserCheckoutTitleItem({
    super.key, required this.data, required this.title, required this.image,
  });

  @override
  Widget build(BuildContext context) {

    return Flexible(
      child: Container(
        padding: EdgeInsets.only(left: 25,right: 5,top: 12,bottom: 18),
        width: double.infinity,
          decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15),
            color: AppTheme
                .of(context)
                .primaryColorLight,),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoTextSizeWidget(title,color: Color(0xff7A7D86),),
                    SizedBox(height:1),
                    Row(
                    children: [
                      GenericImagehandler(
                        image,
                        width: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          data,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffE1E3EB),
                              overflow: TextOverflow.ellipsis),
                        ),

                      ),
                      SizedBox(width: 8,),

                    ],
                  ),
                  ],
                ),
              ),
              GenericImagehandler(Images.cheronRight,height:12 ,)
            ],
          ),
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

class EditButtonWidget extends StatelessWidget {
  const EditButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:()=>Navigator.pop(context),
      child: Container(
        color: Colors.red.withOpacity(0.001),
        padding: const EdgeInsets.only(right: 20,top:20),
        child: AutoTextSizeWidget('Edit'),
      ),
    );
  }
}
