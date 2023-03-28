import 'package:burger_house/models/mixins/validator_mixin.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/pages/main_view/main_manager_view.dart';
import 'package:burger_house/views/pages/sign_up/register_view.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:burger_house/views/widgets/input_widget.dart';
import 'package:burger_house/views/widgets/main_button_widget.dart';
import 'package:burger_house/views/widgets/scaffolds/scaffold_main_app_bar.dart';
import 'package:burger_house/views/pages/sign_in/providers/login_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/two_color_text_widget.dart';

class LoginView extends StatelessWidget with ValidatorMixin<LoginProvider> {
  static const routeName = 'Login';

  final dynamic args;

  const LoginView({Key? key,required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
        create: (_) => LoginProvider(),
        builder: (context, snapshot) {
          return ScaffoldMainAppBar(
            shouldScroll: true,
            backgroundColor: AppTheme.of(context).primaryColor,
            title: '',
            body: Consumer<LoginProvider>(
                builder: (context, provider, snapshot) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:   [

                    const GenericImagehandler(Images.logoFull,width: double.infinity,),
                    const SizedBox(height: 17,),
                    InputWidget(title:'Username',controller:provider.usernameTextController),
                    const SizedBox(height: 11),
                    InputWidget(title:'Password',obscureText: true,controller:provider.passwordTextController),
                    const SizedBox(height: 11,),
                      provider.isLoading
                          ? CircularProgressIndicator()
                          : MainButtonWidget('Login',
                              onTap: () {

                                onValidate(context, provider,args,routeName: MainManagerView.routeName);

                              }),
                      const SizedBox(
                        height: 25,
                      ),

                      const _ForgotPasswordWidget(),
                    ],
                ),
              );
            }),
            stackBottom: TwoColorTextWidget(
                  'Don’t have an account?', 'Create account',
                  onTap: () => AppRoutes.navigate(context, RegisterView.routeName, args)));
        });
  }

  @override
  void onSuccessValidation(BuildContext context, {String? routeName, LoginProvider? provider, GenericArgs? args}) {
    Helper.hideKeyboard(context);
    provider!.login((){
      super.onSuccessValidation(context, routeName:routeName, provider:provider, args: args);

    });
  }


}



class _ForgotPasswordWidget extends StatelessWidget {
  const _ForgotPasswordWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => null,
        child: AutoTextSizeWidget(
          'Forgot Password',
          color: AppTheme.of(context).accentColor,
          fontFamily: FontFamily.poppins,
          fontWeight: FontWeight.w500,

        ),
      ),
    );
  }
}



