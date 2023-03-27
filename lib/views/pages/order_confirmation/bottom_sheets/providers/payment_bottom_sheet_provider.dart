

import 'dart:async';

import 'package:burger_house/data/models/request_models/add_address_requesst.dart';
import 'package:burger_house/data/models/response_model/places_api_response.dart';
import 'package:burger_house/data/repositories/google_api_repo.dart';
import 'package:burger_house/data/repositories/user_repo.dart';
import 'package:burger_house/models/address.dart';
import 'package:burger_house/models/segue_model/segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/utils/cache_helper.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/utils/env.dart';
import 'package:burger_house/utils/formatters/number_formtter.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/utils/validator.dart';
import 'package:burger_house/views/pages/order_confirmation/bottom_sheets/payment_bottom_sheet.dart';
import 'package:burger_house/views/widgets/stream_listner_widget.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uuid/uuid.dart';

class PaymentBottomSheetProvider extends SegueNotifierViewProvider{
  final _userRepo = ServiceLocator.locator<UserRepo>();

  String cardNumber = '';
  String dateText = '';
  String cvv = '';

  PPageState pageState = PPageState.viewPayments;
  String lastRequest = '';
  final _googleApiRepo = ServiceLocator.locator<GoogleApiRepo>();

  PlaceApiResponse? response;

  PaymentBottomSheetProvider(){
    // updateList();
  }

  Timer? timer;

  List<Address> cards = [];
  void onChangeSearch(text){

    if(timer != null) {
      timer!.cancel();
    }
    lastRequest = Uuid().v4();
    var previous = lastRequest;
    timer = Timer(Duration(milliseconds: 300), () {
      _googleApiRepo
          .getPlaces(pullFromNet, text,'CA', Env.get(EnvKey.GOOGLE_API_KEY))
          .then((result) {
            if(previous == lastRequest) {
              response = result;
              //requested denied dont post to the widgetj
              if(result.status != null && !result.status!.toLowerCase().contains(Strings.denied))
              {
                StreamListeningWidget.trigger(StreamObject(
                    name: Strings.searchNotification, object: result));
              }
            }
      });
    });
  }

  void updateList(){
    startLoading();
    _userRepo.getMyAddresses(pullFromDisk()).then((results){
      cards = results;
      stopLoading();
    });
    _userRepo.getMyAddresses(pullFromNet()).then((results){
      cards = results;
    })
    .whenComplete((){
      stopLoading();
    });
  }

  @override
  bool isOk(BuildContext context, {GenericArgs? args}) {
    if(!Validator.isXLong(NumberFormatter.clean(cardNumber),15)){
      throw(DisplayableException('Please enter valid credit card number'));
    }

    Validator.isCCDateValid(dateText);

    if(!Validator.isNotEmpty(cvv)){
      throw(DisplayableException('Please enter 3 digit CVV'));
    }

    if(!Validator.isXLong(NumberFormatter.clean(cvv),3)){
      throw(DisplayableException('Please enter 3 digit CVV'));
    }
    return true;
  }

  @override
  void updateSegueObject({GenericArgs? args}) {
  }

  void updateState(PPageState state) {
    pageState = state;
    notifyListenersSafe();
  }

  Future<void> selectedAddress(Result result) async {
    updateState(PPageState.viewPayments);
    startLoading();

    await _userRepo.addNewAddress(AddAddressRequest(
        address: result.formattedAddress,
        latitude: result.geometry?.location?.lat ?? 0,
        longitude: result.geometry?.location?.lng ?? 0,
    ));
    updateList();
  }

  void removeItem(int index) {
    _userRepo.deleteAddresses(cards[index].id);
    _userRepo.getMyAddresses(pullFromNet()).then((results){});
    cards.removeAt(index);
    notifyListenersSafe();
    if (cards.isEmpty) {
      updateState(PPageState.viewPayments);
    }
  }

  void saveCard() {

  }


}