import 'package:burger_house/models/mixins/validator_mixin.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/pages/sign_up/providers/register_provider.dart';
import 'package:burger_house/views/widgets/banner_widget.dart';
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

class RegisterView extends StatelessWidget with ValidatorMixin<RegisterProvider> {
  static const routeName = 'Register';

  final GenericArgs? args;

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
                     InputWidget(title: 'First Name',controller: provider.firstNameTextController,),
                    const SizedBox(height:20),
                     InputWidget(title: 'Last Name',controller: provider.lastNameTextController,),
                    const SizedBox(height:20),
                     InputWidget(title: 'Email Address',controller: provider.emailTextController,),
                    const SizedBox(height:20),
                     InputWidget(title: 'Password',obscureText: true,controller: provider.passwordTextController,),
                    const SizedBox(height:20),
                     InputWidget(title: 'Type Password Again',obscureText: true,controller: provider.passwordReTextController,),
                    const SizedBox(height:20),
                    provider.isLoading
                        ? CircularProgressIndicator()
                        : MainButtonWidget('Create Account',
                        onTap: () {

                          onValidate(context, provider,args,routeName: null);

                        }),
                  ],
                ),
              );
            }),
            stackBottom: TwoColorTextWidget('Already registered?', ' Login',onTap: ()=>Navigator.pop(context),),
          );
        });
  }

  @override
  void onSuccessValidation(BuildContext context, {String? routeName, RegisterProvider? provider, GenericArgs? args}) {
        Helper.hideKeyboard(context);
        provider!.register((){
          Helper.showToast('Account Create Successfully, you can now sign with you new account',messageType: MessageType.success);
          Navigator.pop(context);
        });
  }
}

