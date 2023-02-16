import 'dart:convert';

import 'package:burger_house/data/models/response_model/token_response.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/utils/local_storage.dart';

import '../data/models/response_model/user_response_model.dart';

class LoginManager {

  static final LocalStorage _localStorage =
  ServiceLocator.locator<LocalStorage>();

  static Future saveTokens(TokenResponse token) async {
    await _localStorage.saveAwaitable(LSKey.ACCESS_TOKEN, token.token);
  }

  static Future<void> saveUser(User value) async {
    await _localStorage.saveAwaitable(LSKey.USER, jsonEncode(value.toJson()));
  }

  static bool isLoggedIn() {
    if (_localStorage.retrieve(LSKey.ACCESS_TOKEN) != null) {
      return true;
    }
    return false;
  }

  static String? getToken() {
    return _localStorage.retrieve(LSKey.ACCESS_TOKEN);
  }

}