import 'package:burger_house/models/menu_food.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:flutter/material.dart';
import 'package:burger_house/theme/app_theme.dart';

import '../../../utils/constants.dart';


class GirdView extends StatelessWidget {
  GirdView({
    super.key,
  });

  final List<MenuItem> items = [
    MenuItem(image: Images.burger1,name: 'Burger Classic',calories: 600,price: 7.99),
    MenuItem(image: Images.burger2,name: 'Burger Supreme',calories: 600,price: 7.99),
    MenuItem(image: Images.burger3,name: 'HOUSE Double',calories: 600,price: 7.99),
    MenuItem(image: Images.burger4,name: 'BH Single',calories: 600,price: 7.99),
    MenuItem(image: Images.burger5,name: 'Bacon Deluxe',calories: 600,price: 7.99),
    MenuItem(image: Images.burger5, name: 'HOUSE Triple',calories: 600,price: 7.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        GridRow(),
        const SizedBox(height: 0,),
        GridRow(),

        const SizedBox(height: 150,)
      ],);
  }
}

class GridRow extends StatelessWidget {

  final menu = MenuItem(image: Images.burger1,name: 'Burger Classic',calories: 600,price: 7.99);
  GridRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Expanded(child: GridItem()),
        SizedBox(width:20),
        Expanded(child: GridItem()),
      ],
    );
  }
}

class GridItem extends StatelessWidget {


  const GridItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    var menu =   MenuItem(image: Images.burger2,name: 'Burger Classic',calories: 600,price: 7.99);
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
                child: GenericImagehandler(menu.image,width: double.infinity,),
              ),
              AutoTextSizeWidget(menu.name,fontWeight: FontWeight.w600,fontSize: 16,),
              const SizedBox(height:5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GenericImagehandler(Images.starIcon,width: 20,),
                  const SizedBox(width: 5,),
                  AutoTextSizeWidget('\$${menu.price}',fontWeight: FontWeight.w600,color: const Color(0xff7A7D86),),
                  const SizedBox(width: 10,),
                  AutoTextSizeWidget('${menu.calories}Cals',fontWeight: FontWeight.w600,color: const Color(0xff7A7D86)),
                ],
              )

            ],
          )
        ],
      ),
    );
  }
}
