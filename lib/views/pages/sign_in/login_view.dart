import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:burger_house/views/widgets/input_widget.dart';
import 'package:burger_house/views/widgets/main_button_widget.dart';
import 'package:burger_house/views/widgets/scaffolds/scaffold_main_app_bar.dart';
import 'package:burger_house/views/pages/sign_in/providers/login_provider.dart';

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
            backgroundColor: AppTheme.of(context).primaryColor,
            title: '',
            body: Consumer<LoginProvider>(
                builder: (context, provider, snapshot) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27),
                child: Column(
                  children:  const [
                    GenericImagehandler(Images.logoFull,width: double.infinity,),
                    SizedBox(height: 17,),
                    InputWidget(title:'Username'),
                    SizedBox(height: 11,),
                    InputWidget(title:'Password',obscureText: true,),
                    SizedBox(height: 11,),
                    MainButtonWidget('Login')
                  ],
                ),
              );
            }),
          );
        });
  }
}

