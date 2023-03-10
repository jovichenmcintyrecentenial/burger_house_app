import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:burger_house/views/widgets/input_widget.dart';
import 'package:burger_house/views/widgets/subtitle_widget.dart';
import 'package:flutter/material.dart';

class MenuView extends StatelessWidget {
  MenuView({
    super.key,
  });

  final List<String> images = [Images.slide1,Images.slide1,Images.slide1,Images.slide1,Images.slide1];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Column(
                children: [
                  GenericImagehandler(Images.menu,width: double.infinity,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Helper.getScaleWidthPercentage(context, 5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const SizedBox(height:22),
                        const SubTitleWidget('Top mouth watering deal of the week'),
                        const SizedBox(height:10),
                        const InputWidget(title:'Search your cravings'),

                        // GirdView()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

      ],
    );
  }
}
