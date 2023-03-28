
import 'package:burger_house/data/models/request_models/order_request_model.dart';
import 'package:burger_house/data/models/response_model/card_response.dart';
import 'package:burger_house/data/models/response_model/menu_item.dart';
import 'package:burger_house/data/models/response_model/order_response_model.dart';
import 'package:burger_house/data/repositories/order_repo.dart';
import 'package:burger_house/models/address.dart';
import 'package:burger_house/models/cart.dart';
import 'package:burger_house/models/segue_model/order_segue_model.dart';
import 'package:burger_house/models/segue_model/segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/utils/cache_helper.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrderConfirmationViewProvider extends SegueNotifierViewProvider<OrderSegueModel>{

  String? paymentMethodId;
  Order? orderDetails ;

  var _cart = ServiceLocator.locator<Cart>();

  Address? address;

  CardResponse? card;

  OrderConfirmationViewProvider(){
    estimateFees();
  }

  var cart = ServiceLocator.locator<Cart>();


  Future<void> estimateFees() async {
    startLoading();
    var orderRequest = OrderRequest();
    orderRequest.estimate = true;
    List<String> menuIds = cart.items.map((MenuItem menuItem)=>menuItem.id.toString()).toList();
    orderRequest.menuItemsIds = menuIds;
    try {
      orderDetails = await ServiceLocator.locator<OrderRepo>().createOrder(
          pullFromNet(), orderRequest);
    }
    catch(e){
      Helper.showToast('Unable to calculate fees');
    }
    finally{
      stopLoading();
    }
  }

  List<MenuItem>  getCartItems(){
    List<MenuItem> menu = [];
    Map<String,bool> existMap = {};

    for(var item in _cart.items){
      if(!existMap.containsKey(item.id)){
        menu.add(item);
        existMap[item.id!] = true;
      }
    }
    return menu;
  }


  @override
  bool isOk(BuildContext context, {GenericArgs<OrderSegueModel>? args}) {

    var noAddressMessage = 'Please select a deliver address';
    var noPaymentMethodMessage = 'Please select a payment method address';

    if(address == null){
      throw DisplayableException(noAddressMessage);
    }

    if(card == null){
      throw DisplayableException(noPaymentMethodMessage);
    }


    return true;
  }

  @override
  void updateSegueObject({GenericArgs<OrderSegueModel>? args}) {
    args!.param.address = address;
    args.param.card = card;
    args.param.menuIds;

  }

}