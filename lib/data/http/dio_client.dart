import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart' as pp;

import '../../utils/env.dart';
import 'inteceptors/api_cache_interceptor.dart';


class DioClient {
  Dio? _dio;

  static Future<void> initGetDBPath() async {
    // var dbPath = await pp.getApplicationDocumentsDirectory();
    // dbStore = DbCacheStore(databasePath: dbPath.path,logStatements: true);
  }



  void initClient() {
    if (_dio != null) return;

    // final options = CacheOptions(
    //   // A default store is required for interceptor.
    //   store:dbStore,
    //   // Default.
    //   policy: CachePolicy.request,
    //   // Optional. Returns a cached response on error but for statuses 401 & 403.
    //   hitCacheOnErrorExcept: [],
    //   // Optional. Overrides any HTTP directive to delete entry past this duration.
    //   maxStale: const Duration(days: 0),
    //   // Default. Allows 3 cache sets and ease cleanup.
    //   priority: CachePriority.normal,
    //   // Default. Body and headers encryption with your own algorithm.
    //   cipher: null,
    //   // Default. Key builder to retrieve requests.
    //   keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    //   // Default. Allows to cache POST requests.
    //   // Overriding [keyBuilder] is strongly recommended.
    //   allowPostMethod: false,
    // );
    _dio = Dio();//..interceptors.add(DioCacheInterceptor(options: options));
    _dio!.interceptors.add(ApiCacheInterceptor().interceptorsWrapper);

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

  Dio getClient() {
    if (_dio == null) initClient();
    return _dio!;
  }



}
