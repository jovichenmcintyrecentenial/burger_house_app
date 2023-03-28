import 'package:burger_house/models/segue_model/order_segue_model.dart';
import 'package:burger_house/views/pages/main_view/main_manager_view.dart';
import 'package:burger_house/views/pages/main_view/menu_type_view.dart';
import 'package:burger_house/views/pages/main_view/profile_view.dart';
import 'package:burger_house/views/pages/order_confirmation/order_confirmation_view.dart';
import 'package:burger_house/views/pages/processing_screen/processing_view.dart';
import 'package:burger_house/views/pages/sign_in/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

import '../utils/helper.dart';
import '../views/pages/sign_up/register_view.dart';

class GenericArgs<T> {
  final T param;

  GenericArgs({
    required this.param,
  });
}

class AppRoutes {

  static final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

  static final router = FluroRouter();

  static bool isCurrentRoute(context,{required routeName}){
    var isCurrentRoute = false;
    var pagesChecked = 0;
    Navigator.popUntil(context, (route) {

      if (route.settings.name == routeName && pagesChecked == 0) {
        isCurrentRoute = true;
      }

      pagesChecked++;
      return true;
    });
    return isCurrentRoute;
  }

  static Future navigate(BuildContext context,String routeName,args){

    return router.navigateTo(
      context,
      routeName,
      transition: TransitionType.material,
      routeSettings: RouteSettings(
        arguments: args,
      )
    );
  }

  static void createRoutes() {

    router.notFoundHandler = Handler(
        handlerFunc: (context, params) {
          Helper.logger.e("ROUTE WAS NOT FOUND !!!");
          return null;
        });
    //DON'T DELETE COMMENT BELOW
    //{{codeGen}}
    router.define(MenuTypeView.routeName, handler: Handler(handlerFunc: (context,params){
      final args = context!.settings!.arguments;
      return MenuTypeView(args: args as String);
    }));
    router.define(MainManagerView.routeName, handler: Handler(handlerFunc: (context,params){
       final args = context!.settings!.arguments;
       return MainManagerView(args: args);
    }));
    router.define(RegisterView.routeName, handler: Handler(handlerFunc: (context,params){
       final args = context!.settings!.arguments;
       return RegisterView(args: args as GenericArgs?);
    }));
    router.define(LoginView.routeName, handler: Handler(handlerFunc: (context,params){
       final args = context!.settings!.arguments;
       return LoginView(args: args);
    }));
    router.define(ProfileView.routeName, handler: Handler(handlerFunc: (context,params){
      return ProfileView();
    }));
    router.define(ProcessingView.routeName, handler: Handler(handlerFunc: (context,params){
      final args = context!.settings!.arguments;
      return ProcessingView(args: args as GenericArgs<OrderSegueModel>?);
    }));
    router.define(OrderConfirmationView.routeName, handler: Handler(handlerFunc: (context,params){
      final args = context!.settings!.arguments;
      return OrderConfirmationView(args: args as GenericArgs<OrderSegueModel>?);
    }));




  }


}