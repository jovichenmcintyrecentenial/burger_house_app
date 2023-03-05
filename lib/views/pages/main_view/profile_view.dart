import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/widgets/app_bars/title_app_bar_widget.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:burger_house/views/widgets/horizontal_divider.dart';
import 'package:burger_house/views/widgets/title_header_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/avatar_widget.dart';

class ProfileView extends StatelessWidget {
  ProfileView({
    super.key,
  });

  final List<String> images = [Images.slide1,Images.slide1,Images.slide1,Images.slide1,Images.slide1];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Helper.getScaleWidthPercentage(context, 5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              AppTitleBar('My Profile'),
              const AvtarWidget(),
              const TitleHeaderWidget('Johnson Brown',fontSize: 29,fontHeight: 1.3,),
                SizedBox(height: 20,),
                Container(decoration: BoxDecoration(
                  color: AppTheme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start
                    ,children:
                  [
                    AutoTextSizeWidget('Settings',fontWeight: FontWeight.w700, color:Color(0xff7A7D86)),
                    SettingListItem(Images.userIcon,'Edit Profile'),
                    SettingListItem(Images.ordersIcon,'My Orders'),
                    SettingListItem(Images.lockIcon,'Change Password',noDivider: true,),
                  ],),
                ),
              ),
              SizedBox(height: 20,),
              SettingListItem(Images.logoutIcon,'Log out',noDivider: true,isIsolated: true,),

            ],
          ),
        ],
      ),
    );
  }
}

class SettingListItem extends StatelessWidget {
  final bool noDivider;
  final bool isIsolated;

  final String title;
  final String image;

  const SettingListItem(this.image,this.title, {this.noDivider = false,
    super.key,  this.isIsolated = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isIsolated?EdgeInsets.symmetric(horizontal: 20):null,
      decoration: isIsolated?BoxDecoration(
        color: AppTheme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(10),
      ):null,
      child: Column(
        children: [
          SizedBox(height: 20,),
          Container(
            child: Row(
              children: [
                GenericImagehandler(image,width: 30,height: 25,),
                const SizedBox(width: 15,),
                AutoTextSizeWidget(title,fontWeight: FontWeight.w500,
                color: Color(0xff7A7D86),)
              ],
            ),
          ),
          SizedBox(height: isIsolated?20:15,),

          !noDivider?HorizontalDivider():SizedBox(),
        ],
      ),
    );
  }
}
