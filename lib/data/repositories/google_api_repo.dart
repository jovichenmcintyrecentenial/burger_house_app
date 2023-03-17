import 'package:burger_house/data/models/request_models/add_user_request.dart';
import 'package:burger_house/data/models/response_model/user_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'google_api_repo.g.dart';

@RestApi()
abstract class GoogleApiRepo {
  factory GoogleApiRepo(Dio dio, {String baseUrl}) = _GoogleApiRepo;

  //get user information
  @GET('/maps/api/place/textsearch/json')
  Future<User> getPlaces(
      @DioOptions() dioOptions,
      @Query('query')  String? query,
      @Query('key')  String? key,
      );
}
