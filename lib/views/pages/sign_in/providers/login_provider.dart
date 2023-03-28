import 'package:burger_house/data/error_builder.dart';
import 'package:burger_house/data/models/request_models/login_request_model.dart';
import 'package:burger_house/data/repositories/authenication_repo.dart';
import 'package:burger_house/data/repositories/user_repo.dart';
import 'package:burger_house/models/segue_model/segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/utils/cache_helper.dart';
import 'package:burger_house/utils/extensions/string_extension.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:flutter/cupertino.dart';

import '../../../../models/login_manager.dart';

class LoginProvider extends SegueNotifierViewProvider {

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  //call login api
  void login(onComplete) {
    startLoading();
    final _authRepo = ServiceLocator.locator<AuthenticationRepo>();
    final _userRepo = ServiceLocator.locator<UserRepo>();
    _authRepo
        .login(LoginRequest(
            email: usernameTextController.text,
            password: passwordTextController.text))
        .then((value) async {
          await LoginManager.saveTokens(value);
          var user = await _userRepo.getUser(pullFromNet());
          await LoginManager.saveUser(user);
          onComplete();
    }).onError(ErrorFactory.showError).whenComplete(() => stopLoading());
  }

  //validate inputted data
  @override
  bool isOk(BuildContext context, {GenericArgs? args}) {
    notifyListenersSafe();
    var username = usernameTextController.text;
    var password = passwordTextController.text;

    if(username.trim().isEmpty){
      throw DisplayableException('Enter an email address');
    }

    if(!username.isValidEmail()){
      throw DisplayableException('Enter a valid email address');
    }

    if(password.trim().isEmpty){
      throw DisplayableException('Enter a password');
    }

    return true;
  }

  @override
  void updateSegueObject({GenericArgs? args}) {
  }

}