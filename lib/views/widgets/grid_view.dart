import 'package:burger_house/data/models/response_model/menu_item.dart';
import 'package:burger_house/models/cart.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/views/pages/main_view/providers/main_manager_view_provider.dart';
import 'package:burger_house/views/pages/main_view/providers/menu_items_base_provider.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:flutter/material.dart';
import 'package:burger_house/theme/app_theme.dart';

import '../../../utils/constants.dart';
import '../../utils/helper.dart';
import '../pages/main_view/menu_type_view.dart';
import 'menu_item_bottom_sheet.dart';

class GirdView extends StatelessWidget {

  final MenuItemBaseProvider provider;

  GirdView({
    super.key,required this.provider
  });

  List<Widget> buildGrids(MenuItemBaseProvider provider){

    if(provider.menuItems == null){
      return [Center(child: CircularProgressIndicator())];
    }
    List<Widget> gridRows = [];
    var index = 1;
    var items = provider.menuItems!;
    for(var _ in items){
      if(index % 2 == 0 && index != 0){
        gridRows.add(GridRow(items[index-2],items[index-1],isType:provider.isType,provider:provider));
      }
      index++;
    }

    if(index % 2 == 0){
      gridRows.add(GridRow(items[index-2],null,isType:provider.isType,provider:provider));
    }

     return gridRows;
  }

  @override
  Widget build(BuildContext _) {
    return Column(
      children:  [
        ...buildGrids(provider),
        const SizedBox(height: 150,)
      ],);
  }
}

class GridRow extends StatelessWidget {
  final MenuItem item1;
  final MenuItem? item2;
  final bool isType;
  final MenuItemBaseProvider provider;


  const GridRow(this.item1, this.item2, {
    this.isType = false, required this.provider,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:  [
        Expanded(child: GridItem(item1,isType: isType,provider:provider)),
        const SizedBox(width:20),
        Expanded(
          child: Opacity(opacity:item2 == null? 0.001:1,
          child: GridItem(item2??item1,isType: isType,provider:provider)),
        ),
      ],
    );
  }
}

class GridItem extends StatelessWidget {

  final MenuItem menu;
  final bool isType;
  final MenuItemBaseProvider provider;

  const GridItem(this.menu,{
    super.key,
    this.isType = false, required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    double height = 220;
    return GestureDetector(
      onTap: () async {

        if(provider.isType)
        {
          AppRoutes.navigate(context,MenuTypeView.routeName,menu.type);
        }
        else {
          Helper.hideKeyboard(context);
          var cartButtonPressed = await showModalBottomSheet<bool>(
            context: context,
            isDismissible: true,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return MenuItemBottomSheet(menu: menu);
            },
          );

          if(cartButtonPressed != null && cartButtonPressed){
            MainManagerProvider.stream.add(3);
            if(provider.isCategory){
              Navigator.pop(context);
            }
          }
        }

      },
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height/1.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: AppTheme.of(context).primaryColorLight,
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GenericImagehandler(menu.imageUrl,width: double.infinity,height: 130,),
                ),
                SizedBox(height: isType?10:0,),
                AutoTextSizeWidget(isType?menu.type!:menu.name!,fontWeight: FontWeight.w600,fontSize: 16,),
                const SizedBox(height:5),
                !isType?Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GenericImagehandler(Images.starIcon,width: 20,),
                    const SizedBox(width: 5,),
                    AutoTextSizeWidget('\$${menu.price}',fontWeight: FontWeight.w600,color: const Color(0xff7A7D86),),
                    const SizedBox(width: 10,),
                    AutoTextSizeWidget('${menu.calories} Cals',fontWeight: FontWeight.w600,color: const Color(0xff7A7D86)),
                  ],
                ):SizedBox()

              ],
            )
          ],
        ),
      ),
    );
  }
}

class GridItem2 extends StatelessWidget {

  final MenuItem menu;
  final double scale;
  final int index;

  const GridItem2(this.menu,{
    this.scale = 1,
    required this.index ,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = 220 * scale;
    double width = 200 * scale;
    double imageHeight = 130 * scale;
    double marginRight = 30 * scale;
    double radius = 25 * scale;
    double paddingHorizontalImage = 8 * scale;
    double fontSize = 16 * scale;
    return Container(
      margin: EdgeInsets.only(right: marginRight,left: index==0?20:0),
      width: width,
      child: Stack(
        children: [

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height/1.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: AppTheme.of(context).primaryColorLight,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20 * scale,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontalImage),
                child: GenericImagehandler(menu.imageUrl,width: width,height: imageHeight,),
              ),
               SizedBox(height:10 * scale),
               AutoTextSizeWidget(menu.name!,fontWeight: FontWeight.w600,fontSize: fontSize,),
               SizedBox(height:5 * scale),

            ],
          ),
          Positioned(
              right: 0,
              top:50*scale,
              child: _MenuItemBadgeWidget(scale: scale, menu: menu)),
        ],
      ),
    );
  }
}

class _MenuItemBadgeWidget extends StatelessWidget {
  const _MenuItemBadgeWidget({
    required this.scale,
    required this.menu,
  });

  final double scale;
  final MenuItem menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35 * scale,
      height: 35 * scale,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color:AppTheme.of(context).accentColor
      ),
      child: Center(
          child: AutoTextSizeWidget(ServiceLocator.locator<Cart>()
              .getAddedMenuItems(menu)
              .toString(),fontSize: 30 * scale,)),
    );
  }
}

