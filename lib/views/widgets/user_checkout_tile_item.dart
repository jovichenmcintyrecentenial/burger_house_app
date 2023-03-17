import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:flutter/material.dart';

class UserCheckoutTitleItem extends StatelessWidget {

  final String data ;
  final String title;

  final String image;
  final Function() onTap;

  const UserCheckoutTitleItem({
    super.key, required this.data, required this.title, required this.image, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Flexible(
      child: GestureDetector(
        onTap: onTap,
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
      ),
    );
  }
}