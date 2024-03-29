

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
import 'package:burger_house/views/pages/order_confirmation/bottom_sheets/address_bottom_sheet.dart';
import 'package:burger_house/views/widgets/stream_listner_widget.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uuid/uuid.dart';

class AddressBottomSheetProvider extends SegueNotifierViewProvider{
  final _userRepo = ServiceLocator.locator<UserRepo>();

  PageState pageState = PageState.viewAddress;
  String lastRequest = '';
  final _googleApiRepo = ServiceLocator.locator<GoogleApiRepo>();

  PlaceApiResponse? response;

  AddressBottomSheetProvider(){
    updateList();
  }

  Timer? timer;

  List<Address> addresses = [];
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
      addresses = results;
      stopLoading();
    });
    _userRepo.getMyAddresses(pullFromNet()).then((results){
      addresses = results;
    })
    .whenComplete((){
      stopLoading();
    });
  }

  @override
  bool isOk(BuildContext context, {GenericArgs? args}) {
    return true;
  }

  @override
  void updateSegueObject({GenericArgs? args}) {
  }

  void updateState(PageState state) {
    pageState = state;
    notifyListenersSafe();
  }

  Future<void> selectedAddress(Result result) async {


    await _userRepo.addNewAddress(AddAddressRequest(
        address: result.formattedAddress,
        latitude: result.geometry?.location?.lat ?? 0,
        longitude: result.geometry?.location?.lng ?? 0,
    ));
    updateState(PageState.viewAddress);
    startLoading();
    updateList();
  }

  void removeItem(int index) {
    _userRepo.deleteAddresses(addresses[index].id);
    _userRepo.getMyAddresses(pullFromNet()).then((results){});
    addresses.removeAt(index);
    notifyListenersSafe();
    if (addresses.isEmpty) {
      updateState(PageState.viewAddress);
    }
  }


}