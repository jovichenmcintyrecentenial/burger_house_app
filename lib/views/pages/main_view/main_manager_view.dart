import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/views/widgets/scaffolds/scaffold_main_app_bar.dart';
import 'package:provider/provider.dart';

import 'providers/main_manager_view_provider.dart';

class MainManagerView extends StatelessWidget {
  static const routeName = 'MainManager';

  final Object? args;

  const MainManagerView({Key? key,required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainManagerProvider>(
        create: (_) => MainManagerProvider(),
        builder: (context, snapshot) {
          return ScaffoldMainAppBar(
            backgroundColor: AppTheme.of(context).primaryColorDark,
            title: '',
            body: Consumer<MainManagerProvider>(
                builder: (context, provider, snapshot) {
              return Text("BODY HERE");
            }),
          );
        });
  }
}
