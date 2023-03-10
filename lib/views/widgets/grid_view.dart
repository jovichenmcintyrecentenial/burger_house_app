import 'package:burger_house/data/models/response_model/menu_item.dart';
import 'package:burger_house/views/pages/main_view/providers/menu_items_base_provider.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:flutter/material.dart';
import 'package:burger_house/theme/app_theme.dart';

import '../../../utils/constants.dart';


class GirdView extends StatelessWidget {

  final MenuItemBaseProvider provider;

  GirdView({
    super.key,required this.provider
  });

  // final List<MenuItem> items = [
  //   MenuItem(imageUrl: Images.burger1,name: 'Burger Classic',calories: 600,price: 7.99),
  //   MenuItem(imageUrl: Images.burger2,name: 'Burger Supreme',calories: 600,price: 7.99),
  //   MenuItem(imageUrl: Images.burger3,name: 'HOUSE Double',calories: 600,price: 7.99),
  //   MenuItem(imageUrl: Images.burger4,name: 'BH Single',calories: 600,price: 7.99),
  //   MenuItem(imageUrl: Images.burger5,name: 'Bacon Deluxe',calories: 600,price: 7.99),
  //   MenuItem(imageUrl: Images.burger5, name: 'HOUSE Triple',calories: 600,price: 7.99),
  //   MenuItem(imageUrl: Images.burger1,name: 'XXX Classic',calories: 600,price: 7.99),
  // ];

  List<Widget> buildGrids(MenuItemBaseProvider provider){

    if(provider.menuItems == null){
      return [Center(child: CircularProgressIndicator())];
    }
    List<Widget> gridRows = [];
    var index = 1;
    var items = provider.menuItems!;
    for(var _ in items){
      if(index % 2 == 0 && index != 0){
        gridRows.add(GridRow(items[index-2],items[index-1]));
      }
      index++;
    }

    if(index % 2 == 0){
      gridRows.add(GridRow(items[index-2],null));
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

  const GridRow(this.item1, this.item2, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:  [
        Expanded(child: GridItem(item1)),
        const SizedBox(width:20),
        Expanded(
          child: Opacity(opacity:item2 == null? 0.001:1,
          child: GridItem(item2??item1)),
        ),
      ],
    );
  }
}

class GridItem extends StatelessWidget {

  final MenuItem menu;

  const GridItem(this.menu,{
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    double height = 220;
    return SizedBox(
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
              AutoTextSizeWidget(menu.name!,fontWeight: FontWeight.w600,fontSize: 16,),
              const SizedBox(height:5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GenericImagehandler(Images.starIcon,width: 20,),
                  const SizedBox(width: 5,),
                  AutoTextSizeWidget('\$${menu.price}',fontWeight: FontWeight.w600,color: const Color(0xff7A7D86),),
                  const SizedBox(width: 10,),
                  AutoTextSizeWidget('${menu.calories} Cals',fontWeight: FontWeight.w600,color: const Color(0xff7A7D86)),
                ],
              )

            ],
          )
        ],
      ),
    );
  }
}
