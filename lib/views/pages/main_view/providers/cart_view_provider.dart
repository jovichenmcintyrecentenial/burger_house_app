import 'package:burger_house/data/models/response_model/menu_item.dart';
import 'package:burger_house/models/cart.dart';
import 'package:burger_house/models/segue_model/segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/views/widgets/stream_listner_widget.dart';
import 'package:flutter/src/widgets/framework.dart';

class CartViewProvider extends SegueNotifierViewProvider{

  var cart = ServiceLocator.locator<Cart>();

  CartViewProvider() {

    StreamListeningWidget.listen<bool>(
      streamName: Strings.cartItemDelete,
      isDisposed: () => isDisposed,
      onTrigger: (streamObject) {
        notifyListenersSafe();
      },

    );
  }

  List<MenuItem>  getCartItems(){
    List<MenuItem> menu = [];
    Map<String,bool> existMap = {};

    for(var item in cart.items){
      if(!existMap.containsKey(item.id)){
        menu.add(item);
        existMap[item.id!] = true;
      }
    }
    return menu;
  }

  @override
  bool isOk(BuildContext context, {GenericArgs? args}) {
    return true;
  }

  @override
  void updateSegueObject({GenericArgs? args}) {
  }

}
