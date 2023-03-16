import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/pages/main_view/providers/menu_type_view_provider.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:burger_house/views/widgets/grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';

import '../../widgets/app_bars/title_app_bar_widget.dart';

class MenuTypeView extends StatelessWidget {

  MenuTypeView({
    super.key,this.args,
  });

  final String? args;
  static var routeName = "MenuTypeView";
  final List<String> images = [Images.slide1,Images.slide1,Images.slide1,Images.slide1,Images.slide1];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MenuViewTypeProvider> (
      create: (_) => MenuViewTypeProvider(args),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: AppTheme.of(context).primaryColor,
          body: Column(
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                      children: [
                        Stack(
                          children: [


                            Column(
                              children: [

                                GenericImagehandler(Images.menu,width: double.infinity,),
                                SizedBox(height: 20,)
                              ],
                            ),
                            AppTitleBar('',color: Colors.transparent,hasLeading:true),
                            Positioned(
                              left: 20,
                              bottom: -15,
                              child: AutoTextSizeWidget(
                                args!,
                                fontFamily: FontFamily.rastanty,
                                fontSize: 100,
                                color: Color(0xffE7B547),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Helper.getScaleWidthPercentage(context, 5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [

                              Consumer<MenuViewTypeProvider>(
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
          ),
        );
      }
    );
  }
}
