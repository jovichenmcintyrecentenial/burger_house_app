
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/views/pages/main_view/providers/menu_items_base_provider.dart';
import 'package:flutter/cupertino.dart';

class MenuViewTypeProvider extends MenuItemBaseProvider{


 @override
 void initalState({String? category}){
  isCategory = true;
  getMenuItems(category:category);
 }

 MenuViewTypeProvider(String? category){
   initalState( category:category);
 }

  @override
  bool isOk(BuildContext context, {GenericArgs? args}) {
    return true;
  }

  @override
  void updateSegueObject({GenericArgs? args}) {
  }

}