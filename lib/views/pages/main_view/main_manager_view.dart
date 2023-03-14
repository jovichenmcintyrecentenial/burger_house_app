import 'package:burger_house/views/pages/main_view/cart_view.dart';
import 'package:burger_house/views/pages/main_view/home_view.dart';
import 'package:burger_house/views/pages/main_view/orders_view.dart';
import 'package:burger_house/views/pages/main_view/profile_view.dart';
import 'package:burger_house/views/widgets/keyboard_visibility_builder.dart';
import 'package:burger_house/views/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'menu_view.dart';
import 'providers/main_manager_view_provider.dart';

class MainManagerView extends StatelessWidget {
  static const routeName = 'MainManager';

  final Object? args;

   MainManagerView({Key? key,required this.args}) : super(key: key);

  final PageController controller = PageController();


  @override
  Widget build(BuildContext context) {
    // Set status bar style to transparent
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return ChangeNotifierProvider<MainManagerProvider>(
        create: (_) => MainManagerProvider(),
        builder: (context, snapshot) {
          return  Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: const Color(0xff231F20),
            body: KeyboardVisibilityBuilder(
                builder: (context, snapshot,isVisible) {
                return Stack(
                  children: [
                    Column(
                      children: [

                        Expanded(
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: controller,
                            children:   <Widget>[
                              HomeView(isKeyboardVisble:isVisible),
                              MenuView(),
                              OrdersView(),
                              CartView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    !isVisible?Align(alignment:Alignment.bottomCenter,child: NavBar(controller)):SizedBox()
                  ],
                );
              }
            ),
          );
        });
  }
}





