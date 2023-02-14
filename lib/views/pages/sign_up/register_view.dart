import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/pages/sign_up/providers/register_provider.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/input_widget.dart';
import 'package:burger_house/views/widgets/main_button_widget.dart';
import 'package:burger_house/views/widgets/title_header_widget.dart';
import 'package:burger_house/views/widgets/two_color_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/views/widgets/scaffolds/scaffold_main_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../widgets/generic_Image_handler.dart';

class RegisterView extends StatelessWidget {
  static const routeName = 'Register';

  final Object? args;

  const RegisterView({Key? key,required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterProvider>(
        create: (_) => RegisterProvider(),
        builder: (context, snapshot) {
          return ScaffoldMainAppBar(
            shouldScroll: true,
            backgroundColor: AppTheme.of(context).primaryColorDark,
            title: '',
            body: Consumer<RegisterProvider>(
                builder: (context, provider, snapshot) {
              return  Padding(
                padding: EdgeInsets.symmetric(horizontal: Helper.getScaleWidthPercentage(context, 5)),
                child: Column(
                  children:  [
                    const GenericImagehandler(Images.logoWords,width: double.infinity,),
                    const SizedBox(height:20),
                    const TitleHeaderWidget('Create Account'),
                    const SizedBox(height:20),
                    const InputWidget(title: 'First Name'),
                    const SizedBox(height:20),
                    const InputWidget(title: 'Last Name'),
                    const SizedBox(height:20),
                    const InputWidget(title: 'Email Address'),
                    const SizedBox(height:20),
                    const InputWidget(title: 'Password',obscureText: true,),
                    const SizedBox(height:20),
                    const InputWidget(title: 'Type Password Again',obscureText: true,),
                    const SizedBox(height:20),
                    MainButtonWidget('Create Account',onTap: ()=>null,)
                  ],
                ),
              );
            }),
            stackBottom: TwoColorTextWidget('Already registered?', ' Login',onTap: ()=>Navigator.pop(context),),
          );
        });
  }
}

