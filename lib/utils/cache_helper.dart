import 'package:dio/dio.dart';
// import 'package:dio_http_cache/dio_http_cache.dart';

Options pullFromNet({timeout,Duration? duration}){
  var options = buildCacheOptions(duration ?? const Duration(days: 10),
      forceRefresh: true);

  if(timeout != null){
    options.receiveTimeout = 10000;
  }

  return options;
}
Options pullFromDisk({Duration? duration}){
  return buildCacheOptions(duration ?? const Duration(days: 10),
      forceRefresh: false);
}

Options buildCacheOptions(Duration duration, {bool forceRefresh = false}) {
  var mapString = <String,dynamic>{};
  mapString['should_cache_data'] = '';
  if(!forceRefresh) {
    mapString['pull_from_disk'] = '';
  }
  else{
    mapString['pull_from_net'] = '';
  }
  var option = Options();
  option.extra = mapString;

  return option;
}

bool isNotUsingCache(Options options){
  return !options.extra!.containsKey('pull_from_disk');
}