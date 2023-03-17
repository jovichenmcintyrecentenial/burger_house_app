// Package imports:

// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'helper.dart';

enum EnvKey {

  PROXY_PORT,
  PROXY_ADDRESS,
  BASE_URL,
  GOOGLE_API_KEY,
  GOOGLE_API_BASE_URL
}

class Env {
  static String? getPlatformSpecificValue(List<EnvKey> keys) {
    String? value;
    for (var key in keys) {
      if (Platform.isAndroid &&
          key.toString().toLowerCase().contains('android')) {
        value = get(key);
      } else if (Platform.isIOS &&
          key.toString().toLowerCase().contains('ios')) {
        value = get(key);
      }
    }

    return value;
  }

  static String? get(EnvKey envKey) {
    final key = _getKeyString(envKey);
    if (_hasValue(key)) {
      return _getValue(key);
    }
    Helper.logger.e('unable to find key ${key.toString()} in env');
    return null;
  }

  static String _getKeyString(EnvKey envKey) {
    final key = envKey.toString().replaceAll('EnvKey.', '');
    return key;
  }

  static bool containsKey(EnvKey envKey) {
    final key = _getKeyString(envKey);
    if (_hasValue(key)) {
      return true;
    }
    return false;
  }

  static String _getValue(String key) {
    return dotenv.env[key]!;
  }

  static bool _hasValue(String key) {
    return dotenv.env.containsKey(key);
  }

  static Future load() async {
    return await dotenv.load(fileName:'config/.env');
  }
}
