import 'package:burger_house/models/login_manager.dart';
import 'package:dio/dio.dart';



class ApiTokenInterceptor {
  late InterceptorsWrapper interceptorsWrapper;


  ApiTokenInterceptor() {
    interceptorsWrapper = InterceptorsWrapper(

        onRequest: (RequestOptions options,
            handler) async => await requestInterceptor(options, handler),);
  }

  Future<void> requestInterceptor(RequestOptions? options, RequestInterceptorHandler handler) async  {

    if(LoginManager.isLoggedIn()) {
      options?.headers['Authorization'] = 'Bearer ${LoginManager.getToken()}';
    }
    return handler.next(options!);
  }

}