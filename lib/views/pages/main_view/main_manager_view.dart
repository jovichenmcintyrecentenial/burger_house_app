import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/widgets/grid_view.dart';
import 'package:burger_house/views/widgets/advert_banner_widget.dart';
import 'package:burger_house/views/widgets/nav_bar.dart';
import 'package:burger_house/views/widgets/subtitle_widget.dart';
import 'package:burger_house/views/widgets/title_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../widgets/avatar_widget.dart';
import '../../widgets/input_widget.dart';
import 'providers/main_manager_view_provider.dart';

class MainManagerView extends StatelessWidget {
  static const routeName = 'MainManager';

  final Object? args;

   MainManagerView({Key? key,required this.args}) : super(key: key);

  final PageController controller = PageController();


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainManagerProvider>(
        create: (_) => MainManagerProvider(),
        builder: (context, snapshot) {
          return  Scaffold(
            backgroundColor: const Color(0xff231F20),
            body: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                        height: kToolbarHeight),
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller,
                        children:   <Widget>[
                          Center(
                            child: HomeView(),
                          ),
                          const Center(
                            child: InputWidget(title:'ss'),
                          ),
                          const Center(
                            child: InputWidget(title:'ss'),
                          ),
                          const Center(
                            child: InputWidget(title:'ss'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(alignment:Alignment.bottomCenter,child: NavBar(controller))
              ],
            ),
          );
        });
  }
}


class HomeView extends StatelessWidget {
  HomeView({
    super.key,
  });

  final List<String> images = [Images.slide1,Images.slide1,Images.slide1,Images.slide1,Images.slide1];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Helper.getScaleWidthPercentage(context, 5)),
        child: Stack(

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
                GirdView()
              ],
            ),
          ],
        ),
      ),
    );
  }
}



