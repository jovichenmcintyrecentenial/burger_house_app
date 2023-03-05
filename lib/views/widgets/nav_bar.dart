import 'dart:ui';

import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/widgets/color_change_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';




class NavBar extends StatefulWidget {
  final PageController pageController;

  const NavBar(this.pageController, {
    Key? key,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  var selectedIndex = 0;
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
                NavButtonItem(isActive: _isActive(0), image: Images.homeIcon, onTap: () =>jumpToPage(0),title: 'Home',),
                NavButtonItem(isActive: _isActive(1), image: Images.menuIcon, onTap: () =>jumpToPage(1),title: ('Menu'),),
                NavButtonItem(isActive: _isActive(2), image: Images.orderIcon,onTap: () =>jumpToPage(2),title: ('Orders'),),
                NavButtonItem(isActive: _isActive(3), image: Images.cartIcon, onTap:   () =>jumpToPage(3),title: ('Cart'),),
              ],
            ),
          ),
        ),

      ],
    );
  }

  bool _isActive(num) {
    return widget.pageController.page?.toInt() == num;
  }

  void jumpToPage(int i) {
    setState(() {

    });;
    widget.pageController.jumpToPage(i);
  }
}

class NavButtonItem extends StatelessWidget {

  final String image;
  final Function onTap;
  final bool isActive;

  final String title;

  const NavButtonItem({
    Key? key, required this.image, required this.onTap,required this.title,  this.isActive = false,
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
                color:  isActive?AppTheme.of(context).accentColor:AppTheme.of(context).primaryColorDark,
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
