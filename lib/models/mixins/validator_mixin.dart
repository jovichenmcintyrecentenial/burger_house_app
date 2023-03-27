import 'package:burger_house/models/segue_model/segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:flutter/cupertino.dart';



mixin ValidatorMixin<T extends SegueNotifierViewProvider> {

  void onValidate(BuildContext context, T provider,GenericArgs? args, {String? routeName, shouldHideKeyboard = true})  {
    Helper.showErrorException(() {
      if (provider.isOk(context, args: args)) {
        provider.updateSegueObject(args: args);
        onSuccessValidation(context,routeName: routeName,provider: provider,args: args);
      }
      else{
        onFailValidation(context);
      }
    }, context: context,shouldHideKeyboard: shouldHideKeyboard);
  }

  void onSuccessValidation(BuildContext context, { String? routeName, T? provider,GenericArgs? args }){
    if(routeName != null){
      AppRoutes.navigate(context,routeName, args);
    }
  }

  void onFailValidation(BuildContext context){

  }


}