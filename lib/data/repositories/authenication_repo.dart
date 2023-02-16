import 'package:burger_house/data/models/request_models/login_request_model.dart';
import 'package:burger_house/data/models/response_model/token_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'authenication_repo.g.dart';

@RestApi()
abstract class AuthenticationRepo {
  factory AuthenticationRepo(Dio dio, {String baseUrl}) = _AuthenticationRepo;

  //add DioOptions for the ability to use cache

  @POST('/users/login')
  Future<TokenResponse> login(
      @Body() LoginRequest loginRequest);

}
