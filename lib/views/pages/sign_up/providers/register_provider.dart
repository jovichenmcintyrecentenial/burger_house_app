import 'package:burger_house/data/error_builder.dart';
import 'package:burger_house/data/models/request_models/add_user_request.dart';
import 'package:burger_house/data/repositories/user_repo.dart';
import 'package:burger_house/models/segue_model/segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/utils/extensions/string_extension.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:flutter/material.dart';

class RegisterProvider extends SegueNotifierViewProvider{

  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final passwordReTextController = TextEditingController();

  //call login api
  void register(onComplete) {
    startLoading();
    final _userRepo = ServiceLocator.locator<UserRepo>();
    _userRepo
        .register(AddUserRequest(
        firstName: firstNameTextController.text,
        lastName: lastNameTextController.text,
        emailAddress: emailTextController.text,
        password: passwordTextController.text))
        .then((value) async {
      onComplete();
    }).onError(ErrorFactory.showError).whenComplete(() => stopLoading());
  }


  @override
  bool isOk(BuildContext context, {GenericArgs? args}) {
    var fname = firstNameTextController.text;
    var lname = lastNameTextController.text;
    var email = emailTextController.text;
    var pwd = passwordTextController.text;
    var rePwd = passwordReTextController.text;

    if(fname.trim().isEmpty){
      throw DisplayableException('Enter your first name');
    }
    if(fname.trim().isNumeric()){
      throw DisplayableException('Enter your first name can\'t be only numbers');
    }

    if(lname.trim().isEmpty){
      throw DisplayableException('Enter your last name');
    }

    if(email.trim().isNumeric()){
      throw DisplayableException('Enter an email address');
    }

    if(!email.trim().isValidEmail()){
      throw DisplayableException('Enter a valid email address');
    }

    if(pwd.trim().isEmpty){
      throw DisplayableException('Enter a password');
    }

    if(pwd.trim().length < 8 || pwd.trim().isNumeric()){
      throw DisplayableException('Password must be at least 8 characters long and be alphanumeric');
    }

    if(rePwd.trim().isEmpty){
      throw DisplayableException('Enter a re-password');
    }

    if(rePwd.trim() != pwd.trim()){
      throw DisplayableException('Passwords doesn\'t match please re-enter your password');
    }

    return true;
  }

  @override
  void updateSegueObject({GenericArgs? args}) {
  }




}