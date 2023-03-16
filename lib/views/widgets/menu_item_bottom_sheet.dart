import 'package:burger_house/data/models/response_model/menu_item.dart';
import 'package:burger_house/models/cart.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:burger_house/views/widgets/stream_listner_widget.dart';
import 'package:burger_house/views/widgets/subtitle_widget.dart';
import 'package:burger_house/views/widgets/title_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:burger_house/theme/app_theme.dart';

import '../../../utils/constants.dart';
import '../../services/service_locator.dart';
import '../../utils/helper.dart';
import 'cart_button.dart';
class MenuItemBottomSheet extends StatelessWidget {
  const MenuItemBottomSheet({
    super.key,
    required this.menu,
  });

  final MenuItem menu;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 47),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40,),
            TitleHeaderWidget(menu.name!),
            SubTitleWidget(menu.type!),
            const SizedBox(height: 16,),

            GenericImagehandler(menu.imageUrl,width: Helper.getScaleHeightPercentage(context,40)),
            const SizedBox(height: 32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconTextWidget('${menu.prepareTime} min',image:Images.clockIcon),
                IconTextWidget('${menu.prepareTime} cals',image:Images.flameIcon),
                IconTextWidget('${menu.prepareTime} likes',image:Images.starIcon),
                SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 24,),
            Flexible(
              child: SingleChildScrollView(
                  child: AutoTextSizeWidget(
                    menu.description!,
                    fontSize: 14,
                    color: Colors.white,maxLine: 100,
                  )),
            ),
            const SizedBox(height: 35,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoTextSizeWidget('\$${menu.price!}',fontWeight: FontWeight.w700,fontSize: 32,),
                StepperWidget(menu),
                CartButton(onTap:(){
                  Navigator.pop(context,true);
                })
              ],
            ),
            SizedBox(height: 60,)
          ],
        ),
      ),
    );
  }
}

class StepperWidget extends StatefulWidget {


  final MenuItem menuItem;

  final bool smallerFonts ;
  const StepperWidget(this.menuItem, {
    this.smallerFonts = false
  });

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  final cart = ServiceLocator.locator<Cart>();

  int count = 0;

  @override
  void initState() {
    super.initState();
    count = cart.getAddedMenuItems(widget.menuItem);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: ()=>decrement(),
          child: Container(
            color: Colors.black.withOpacity(0.01),
            height: 50,
            width: 50,
            child: Center(
              child: GenericImagehandler(Images.minusIcon,width: 18,height: 18,),
            ),
          ),
        ),
        AutoTextSizeWidget('$count',fontWeight: FontWeight.w500,fontSize: widget.smallerFonts?25:32,),
        GestureDetector(
          onTap: ()=>increment(),
          child: Container(
            color: Colors.black.withOpacity(0.01),
            height: 50,
            width: 50,
            child: Center(
              child: GenericImagehandler(Images.addIcon,width: 18,height: 18,),
            ),
          ),
        ),
      ],
    );
  }

  decrement() {
    count--;
    if(count < 0){
      count = 0;
    }
    else{
      cart.removeItem(widget.menuItem);
      setState(() {});
    }
    StreamListeningWidget.trigger(StreamObject(name: Strings.cartUpdate, object: true));

  }

  increment() {
    count++;
    cart.addItem(widget.menuItem);

    setState(() {

    });
    StreamListeningWidget.trigger(StreamObject(name: Strings.cartUpdate, object: true));

  }
}


class IconTextWidget extends StatelessWidget {
  const IconTextWidget(this.title, {
    super.key,
    required this.image,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GenericImagehandler(image,width:24,height:24),
        SizedBox(width: 5,),
        AutoTextSizeWidget(title,color: Colors.white,fontSize: 14,)
      ],
    );
  }
}