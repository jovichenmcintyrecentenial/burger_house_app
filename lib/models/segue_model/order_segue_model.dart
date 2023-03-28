

import 'package:burger_house/data/models/request_models/order_request_model.dart';
import 'package:burger_house/data/models/response_model/card_response.dart';
import 'package:burger_house/data/repositories/order_repo.dart';
import 'package:burger_house/models/address.dart';
import 'package:burger_house/models/cart.dart';
import 'package:burger_house/models/segue_model/segue_model.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/utils/cache_helper.dart';
import 'package:burger_house/views/pages/main_view/providers/main_manager_view_provider.dart';
import 'package:flutter/widgets.dart';

class OrderSegueModel extends SegueModel {
  Address? address;
  var _orderRepo = ServiceLocator.locator<OrderRepo>();

  CardResponse? card;

  List<String>? menuIds = [];

  Future<dynamic> createOrder() async {
    var order = await _orderRepo.createOrder(
        pullFromNet, (OrderRequest(menuItemsIds: menuIds, estimate: false)));
    return await _orderRepo.verifyOrder(order.id!);
  }

  @override
  void onComplete(BuildContext context) {
    super.onComplete(context);
    MainManagerProvider.stream.add(2);
    ServiceLocator.locator<Cart>().clearCart();
  }


  @override
  void preProcessing(BuildContext context) {
    type = SegueType.other;

    title = 'Create Order';
    onStartTitle = 'Order Processing...';
    onStart = 'Your order is currently being processed.';
    onSuccessTitle = 'Order Successful';
    onSuccess = 'We have started preparing your order. Monitor your order progress';
    onFailTitle = 'Order Failed';
    onFail = 'Oops something went wrong, please try again later...';

    apiRequest = () => createOrder();



  }
}