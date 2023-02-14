import 'package:burger_house/views/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:provider/provider.dart';

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
            backgroundColor: AppTheme.of(context).primaryColor,
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller,
                        children:  const <Widget>[
                          Center(
                            child: InputWidget(title:'ss'),
                          ),
                          Center(
                            child: InputWidget(title:'ss'),
                          ),
                          Center(
                            child: InputWidget(title:'ss'),
                          ),
                          Center(
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
