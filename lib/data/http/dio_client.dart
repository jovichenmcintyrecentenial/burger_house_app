import 'dart:io';

import 'package:burger_house/data/http/inteceptors/api_token_interceptor.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../../utils/env.dart';
import 'inteceptors/api_cache_interceptor.dart';


class DioClient {
  Dio? _dio;

  static Future<void> initGetDBPath() async {
  }

  void initClient({bool needsAuth = true}) {
    if (_dio != null) return;

    _dio = Dio();
    _dio!.interceptors.add(ApiCacheInterceptor().interceptorsWrapper);
    if(needsAuth) {
      _dio!.interceptors.add(ApiTokenInterceptor().interceptorsWrapper);
    }
    //proxy
    if (Env.containsKey(EnvKey.PROXY_PORT) &&
        Env.containsKey(EnvKey.PROXY_ADDRESS)) {
      (_dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.findProxy = (uri) {
          //proxy all request to localhost:8888
          return 'PROXY ${Env.get(EnvKey.PROXY_ADDRESS)}:${Env.get(EnvKey.PROXY_PORT)}';
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  Dio getClient({bool needsAuth = true}) {
    if (_dio == null) initClient(needsAuth:needsAuth);
    return _dio!;
  }



}
