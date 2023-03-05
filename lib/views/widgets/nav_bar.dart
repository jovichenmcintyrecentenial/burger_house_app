import 'dart:ui';

import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/widgets/color_change_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';




class NavBar extends StatelessWidget {
  final PageController pageController;

  const NavBar(this.pageController, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
              child:  Container(
                color: const Color(0xff231F20).withOpacity(0.78),
                width: double.infinity,
                height: 100,
              ),
            ),
          ),
        ),
        SafeArea(
          child: Container(
            height: 73,
            margin: const EdgeInsets.only(left: 20 ,right: 20,bottom: 30),
            padding: EdgeInsets.symmetric(horizontal: Helper.getScaleWidthPercentage(context, 10)),
            decoration:  BoxDecoration(
              color: AppTheme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavButtonItem(image: Images.homeIcon, onTap: () =>pageController.jumpToPage(0),title: 'Home',),
                NavButtonItem(image: Images.menuIcon, onTap: () =>pageController.jumpToPage(1),title: ('Menu'),),
                NavButtonItem(image: Images.orderIcon,onTap: () =>pageController.jumpToPage(2),title: ('Orders'),),
                NavButtonItem(image: Images.cartIcon, onTap:   () =>pageController.jumpToPage(3),title: ('Cart'),),
              ],
            ),
          ),
        ),

      ],
    );
  }
}

class NavButtonItem extends StatelessWidget {

  final String image;
  final Function onTap;

  final String title;

  const NavButtonItem({
    Key? key, required this.image, required this.onTap,required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(

        width: Helper.getScaleWidthPercentage(context, 15),
        color: Colors.black.withOpacity(0.001),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorChangeWidget(
                color: const Color(0xff231F20),
                child: GenericImagehandler(
                  image,
                  height: 37,
                  width: 37,
                )),

            // AutoTextSizeWidget(title ,fontSize: 13, fontWeight: FontWeight.w600,)
          ],
        ),
      ),
    );
  }
}
