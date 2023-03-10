import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/pages/main_view/providers/home_view_provider.dart';
import 'package:burger_house/views/widgets/advert_banner_widget.dart';
import 'package:burger_house/views/widgets/grid_view.dart';
import 'package:burger_house/views/widgets/input_widget.dart';
import 'package:burger_house/views/widgets/subtitle_widget.dart';
import 'package:burger_house/views/widgets/title_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/avatar_widget.dart';

class HomeView extends StatelessWidget {
  HomeView({
    super.key,
  });

  final List<String> images = [Images.slide1,Images.slide1,Images.slide1,Images.slide1,Images.slide1];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>HomeViewProvider(),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Helper.getScaleWidthPercentage(context, 5)),
          child: Column(
            children: [
              const SizedBox(
                  height: kToolbarHeight),
              Stack(

                children: [
                  Positioned(
                    right: Helper.getScaleWidthPercentage(context,5),
                    top: 10,
                    child: const AvtarWidget(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children:  [

                      const SizedBox(height:22),

                      const SubTitleWidget('Hello Johnson',fontWeight: FontWeight.w500,),
                      const TitleHeaderWidget('Hungry Now?',fontSize: 29,fontHeight: 1.3,),
                      const SizedBox(height:22),
                      const InputWidget(title:'Search your cravings'),
                      const SizedBox(height:22),
                      const TitleHeaderWidget('HOUSE Deal!',fontSize: 29,fontHeight: 1.3,),
                      const SubTitleWidget('Top mouth watering deal of the week'),
                      const SizedBox(height:22),
                      AdvertBanner(images),
                      const SizedBox(height:15),
                      const TitleHeaderWidget('Popular',fontSize: 29,fontHeight: 1.3,),
                      const SubTitleWidget('Top orders in the HOUSE!'),
                      Consumer<HomeViewProvider>(
                        builder: (context,provider, snapshot) {
                          return GirdView(provider: provider,);
                        }
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
