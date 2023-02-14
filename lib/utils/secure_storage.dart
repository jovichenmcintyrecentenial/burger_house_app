// ignore_for_file: constant_identifier_names

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum SSkeys { KEY }

class SecureStore {
  static FlutterSecureStorage? _secureStorage;

  static SecureStore init() {
    _secureStorage = const FlutterSecureStorage();
    return SecureStore();
  }

  ///Securely stores a [value] with the given [key]
  void write(String key, String value) async {
    await _secureStorage!.write(key: key.toString(), value: value);
  }

  Future<String?> read(String key) async {
    var value = await _secureStorage!.read(key: key);
    return value;
  }

  void delete(String key) async {
    await _secureStorage!.delete(key: key.toString());
  }

  void deleteAll(SSkeys key) async {
    await _secureStorage!.deleteAll();
  }
}
