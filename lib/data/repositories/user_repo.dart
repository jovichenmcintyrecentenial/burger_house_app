import 'package:burger_house/data/models/response_model/user_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'user_repo.g.dart';

@RestApi()
abstract class UserRepo {
  factory UserRepo(Dio dio, {String baseUrl}) = _UserRepo;

  //add DioOptions for the ability to use cache
  @GET('/users/me')
  Future<User> getUser(
      @DioOptions() dioOptions);

}
