import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import 'package:dio_cache_interceptor_db_store/dio_cache_interceptor_db_store.dart';
import 'package:path_provider/path_provider.dart';

class ApiCacheInterceptor {
  late InterceptorsWrapper interceptorsWrapper;

  final _dioCache = DioCacheInterceptor(options: CacheService.options);

  ApiCacheInterceptor(){
    interceptorsWrapper = InterceptorsWrapper(
        onResponse: (Response response,handler) async =>  handler.next(await responseInterceptor(response,handler)),
        onRequest: (RequestOptions options,handler) async => await requestInterceptor(options,handler),
        onError: (error,handler) => handler.next(errorInterceptor(error,handler)));
  }

  Future<void> requestInterceptor(RequestOptions? options, RequestInterceptorHandler handler) async  {
    //check if extra specificed to pull from disk
    if(options?.extra != null && options!.extra.containsKey('pull_from_disk')) {
      final key = CacheService.options.keyBuilder(options);
      final cache = await CacheService.options.store?.get(key);

      //if data was found resolve response else throw an error and don't continue
      if(cache != null) {
        var data = cache.toResponse(options, fromNetwork: false);
        return handler.resolve(data);
      }

      else{
        return handler.reject(DioError(
            error: 'No cached data found',
            response:
            Response(data: 'No cached data found', requestOptions: options),
            requestOptions: options));
      }
    }


    return handler.next(options!);
  }

  DioError errorInterceptor(DioError error, ErrorInterceptorHandler handler) {
    return error;
  }

  Future<Response> responseInterceptor(Response response, ResponseInterceptorHandler handler) async {
    var options = response.requestOptions;

    if( options.extra.containsKey('should_cache_data')) {
      options.extra[CacheResponse.requestSentDate] = DateTime.now();
      options.extra.addAll(CacheService.options.copyWith(policy: CachePolicy.forceCache).toExtra());
      _dioCache.onResponse(response, ResponseInterceptorHandler());
    }


    return response;
  }



}


class CacheService{
  CacheService._();
  static late CacheOptions options;
  static Future init() async {
    var appDocDir = await getApplicationDocumentsDirectory();
    var appDocPath = appDocDir.path;

    // Global options
    options = CacheOptions(
      // A default store is required for interceptor.
      store: DbCacheStore(databasePath: '$appDocPath/dio_cache' ),

      // All subsequent fields are optional.

      // Default.
      policy: CachePolicy.noCache,
      // Returns a cached response on error but for statuses 401 & 403.
      // Also allows to return a cached response on network errors (e.g. offline usage).
      // Defaults to [null].
      hitCacheOnErrorExcept: [ 401, 403],
      // Overrides any HTTP directive to delete entry past this duration.
      // Useful only when origin server has no cache config or custom behaviour is desired.
      // Defaults to [null].
      maxStale: const Duration(days: 20),
      // Default. Allows 3 cache sets and ease cleanup.
      priority: CachePriority.high,
      // Default. Body and headers encryption with your own algorithm.
      cipher: null,
      // Default. Key builder to retrieve requests.
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      // Default. Allows to cache POST requests.
      // Overriding [keyBuilder] is strongly recommended when [true].
      allowPostMethod: false,
    );
  }

}