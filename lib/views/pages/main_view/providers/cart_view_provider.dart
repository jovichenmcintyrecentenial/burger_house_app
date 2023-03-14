import 'package:burger_house/data/models/request_models/order_request_model.dart';
import 'package:burger_house/data/models/response_model/menu_item.dart';
import 'package:burger_house/data/models/response_model/order_response_model.dart';
import 'package:burger_house/data/repositories/order_repo.dart';
import 'package:burger_house/models/cart.dart';
import 'package:burger_house/models/segue_model/segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/utils/cache_helper.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:flutter/src/widgets/framework.dart';

class CartViewProvider extends SegueNotifierViewProvider{

  Order? orderDetails ;

  var cart = ServiceLocator.locator<Cart>();

  CartViewProvider(){
    estimateFees();
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

  Future<void> estimateFees() async {
    var orderRequest = OrderRequest();
    orderRequest.estimate = true;
    List<String> menuIds = cart.items.map((MenuItem menuItem)=>menuItem.id.toString()).toList();
    orderRequest.menuItemsIds = menuIds;
    try {
      orderDetails = await ServiceLocator.locator<OrderRepo>().getFeeEstimate(
          pullFromNet(), orderRequest);
    }
    catch(e){
      Helper.showToast('Unable to calculate fees');
    }
    finally{
      stopLoading();
    }
  }

  @override
  bool isOk(BuildContext context, {GenericArgs? args}) {
    return true;
  }

  @override
  void updateSegueObject({GenericArgs? args}) {
  }

}
