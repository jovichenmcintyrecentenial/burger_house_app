import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

import '../utils/helper.dart';


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
    router.define(LoginView.routeName, handler: Handler(handlerFunc: (context,params){
       final args = context!.settings!.arguments;
       return LoginView(args: args);
    }));
    router.define(TransactionDetailsView.routeName, handler: Handler(handlerFunc: (context,params){
       final args = context!.settings!.arguments;
       return TransactionDetailsView(args: args);
    }));



  }


}