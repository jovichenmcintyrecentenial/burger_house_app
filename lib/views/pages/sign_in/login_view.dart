import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/views/widgets/scaffolds/scaffold_main_app_bar.dart';
import 'package:burger_house/views/pages/sign_in/providers/login_provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  static const routeName = 'Login';

  final Object? args;

  const LoginView({Key? key,required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
        create: (_) => LoginProvider(),
        builder: (context, snapshot) {
          return ScaffoldMainAppBar(
            backgroundColor: AppTheme.of(context).primaryColorDark,
            title: '',
            body: Consumer<LoginProvider>(
                builder: (context, provider, snapshot) {
              return const Text("BODY HERE");
            }),
          );
        });
  }
}
