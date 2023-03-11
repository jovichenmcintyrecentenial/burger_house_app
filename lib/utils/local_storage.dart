// ignore_for_file: constant_identifier_names

import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _prefs;

  Future<String> getJson({required String? file}) {
    return rootBundle.loadString('assets/json/${file!}.json');
  }


  Future<String> getFile({required String? file}) {
    return rootBundle.loadString('assets/${file!}');
  }

  /// Use this new method to save data to storage,
  /// be sure to add your key to LSKey enum
  Future<bool> saveAwaitable(dynamic key, String data) async {
    return await LocalStorage._prefs.setString(key.toString(), data);
  }

  static Future<LocalStorage> create() async {
    LocalStorage._prefs = await SharedPreferences.getInstance();
    return LocalStorage();
  }

  /// Use this new method to retrieve data from storage,
  /// be sure to add your key to LSKey enum
  String? retrieve(key) {
    return LocalStorage._prefs.getString(key.toString());
  }

  /// Use this new method to save data to storage,
  /// be sure to add your key to LSKey enum
  void save(dynamic key, String data) {
    LocalStorage._prefs.setString(key.toString(), data);
  }

  void remove(LSKey key) {
    LocalStorage._prefs.remove(key.toString());
  }

  void clearAll({List<dynamic>? exclude}) {
    if (exclude == null) {
      LocalStorage._prefs.clear();
      return;
    }

    var tempValues = <dynamic>[];

    //extract key value in excluded List
    for (final value in exclude) {
      tempValues.add(LocalStorage._prefs.getString(value.toString()));
    }
    //clear all
    LocalStorage._prefs.clear();

    //add back excludes items
    for (var x = 0; x < tempValues.length; x++) {
      LocalStorage._prefs.setString(exclude[x].toString(), tempValues[x]);
    }
  }

  bool containsKey(key) {
    return LocalStorage._prefs.containsKey(key.toString());
  }
}

/// Define all keys used in local storage under this enum, this prevents passing
/// around strings as keys which can easily cause errors that are difficul to
/// debug if strings are mistyped. (LocalStorageKey)
enum LSKey {
  ACCESS_TOKEN,
  SUBSCRIPTIONS,
  REFRESH_TOKEN,
  PUBLIC_ACCESS_TOKEN,
  LAST_LOGIN_IN_COUNTRY,
  APP_CONTACTS,
  APP_CONTACTS_CHECKED,
  IS_FIRST_LAUNCH,
  USER,
  FAVOURITES,
  USER_BALANCE,
  WALLET_BALANCES,
  FX_CHARTS,
  UNIQUE_DEVICE_ID,
  WALLET_ADDRESS, CART,
}
