import 'package:burger_house/data/models/response_model/menu_item.dart';
import 'package:burger_house/data/repositories/menu_repo.dart';
import 'package:burger_house/models/segue_model/segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/utils/cache_helper.dart';
import 'package:flutter/cupertino.dart';

class MenuItemBaseProvider extends SegueNotifierViewProvider {
  List<MenuItem>? menuItems;

  var  searchController = TextEditingController();

  void onChangeSearch(String text){
    if(text.isNotEmpty) {
      getMenuItems(isPopular: false, search: text);
    }
    else{
      initalState();
    }
  }

  void initalState(){

  }

  void getMenuItems({var isPopular = false, var search = null}) async {
    startLoading();

    //pull from cache
    ServiceLocator.locator<MenuRepo>()
        .getMenuItems(pullFromDisk(), isPopular: isPopular,searchQuery: search )
        .then((items) {
          menuItems = items;
          notifyListenersSafe();
    });

    //pull from net
    ServiceLocator.locator<MenuRepo>()
        .getMenuItems(pullFromNet(), isPopular: isPopular,searchQuery: search )
        .then((items) {
      menuItems = items;
      notifyListenersSafe();
    });
  }

  @override
  bool isOk(BuildContext context, {GenericArgs? args}) {
    return true;
  }

  @override
  void updateSegueObject({GenericArgs? args}) {
  }
}