import 'dart:async';

import 'package:burger_house/data/models/request_models/add_card_request.dart';
import 'package:burger_house/data/models/response_model/card_response.dart';
import 'package:burger_house/data/models/response_model/places_api_response.dart';
import 'package:burger_house/data/repositories/user_repo.dart';
import 'package:burger_house/models/segue_model/segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/utils/cache_helper.dart';
import 'package:burger_house/utils/formatters/number_formtter.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/utils/validator.dart';
import 'package:burger_house/views/pages/order_confirmation/bottom_sheets/payment_bottom_sheet.dart';
import 'package:flutter/src/widgets/framework.dart';

class PaymentBottomSheetProvider extends SegueNotifierViewProvider{
  final _userRepo = ServiceLocator.locator<UserRepo>();

  String cardNumber = '';
  String dateText = '';
  String cvv = '';

  PPageState pageState = PPageState.viewPayments;
  String lastRequest = '';

  PlaceApiResponse? response;

  PaymentBottomSheetProvider(){
    updateList();
  }

  Timer? timer;

  List<CardResponse> cards = [];


  void updateList(){
    startLoading();
    _userRepo.getMyCards(pullFromDisk()).then((results){
      cards = results;
      stopLoading();
    });
    _userRepo.getMyCards(pullFromNet()).then((results){
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


  void removeItem(int index) {
    _userRepo.deleteCards(cards[index].id);
    _userRepo.getMyCards(pullFromNet()).then((results){});
    cards.removeAt(index);
    notifyListenersSafe();
    if (cards.isEmpty) {
      updateState(PPageState.viewPayments);
    }
  }

  void saveCard() {
    startLoading();
    _userRepo
        .addNewCards(AddCardRequest(
            cardDate: dateText, cardNumber: cardNumber, cvv: int.parse(cvv)))
        .whenComplete(() {
      _userRepo.getMyCards(pullFromNet()).then((results){
        cards = results;
        isLoading = false;
        updateState(PPageState.viewPayments);
      });
    });
  }


}