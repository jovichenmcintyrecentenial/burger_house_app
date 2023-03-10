
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/views/pages/main_view/providers/menu_items_base_provider.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeViewProvider extends MenuItemBaseProvider{

  HomeViewProvider(){
    getMenuItems(isPopular:true);
  }

  @override
  bool isOk(BuildContext context, {GenericArgs? args}) {
    return true;
  }

  @override
  void updateSegueObject({GenericArgs? args}) {
  }

}