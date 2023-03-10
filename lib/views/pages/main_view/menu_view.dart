import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/pages/main_view/providers/menu_view_provider.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:burger_house/views/widgets/grid_view.dart';
import 'package:burger_house/views/widgets/input_widget.dart';
import 'package:burger_house/views/widgets/subtitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuView extends StatelessWidget {
  MenuView({
    super.key,
  });

  final List<String> images = [Images.slide1,Images.slide1,Images.slide1,Images.slide1,Images.slide1];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MenuViewProvider>(
      create: (_)=>MenuViewProvider(),
      builder: (context, snapshot) {
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
                            Consumer<MenuViewProvider>(
                                builder: (context,provider, snapshot) {
                                  return InputWidget(
                                      title: 'Search your cravings',
                                      onChangeText: provider
                                          .onChangeSearch);
                                }
                            ),

                            Consumer<MenuViewProvider>(
                                builder: (context,provider, snapshot) {
                                  return GirdView(provider: provider,);
                                }
                            )
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
    );
  }
}
