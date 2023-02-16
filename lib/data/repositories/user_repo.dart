import 'package:burger_house/data/models/request_models/add_user_request.dart';
import 'package:burger_house/data/models/response_model/user_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'user_repo.g.dart';

@RestApi()
abstract class UserRepo {
  factory UserRepo(Dio dio, {String baseUrl}) = _UserRepo;

  //get user information
  @GET('/users/me')
  Future<User> getUser(
      @DioOptions() dioOptions);

  //add a user
  @POST('/users')
  Future<User> register(
      @Body() AddUserRequest userRequest);

}
