import 'package:burger_house/models/segue_model/order_segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/views/pages/order_confirmation/providers/order_confirmation_provider.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
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
                Container(
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
                )
              ],
            ),
          );
        }
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
