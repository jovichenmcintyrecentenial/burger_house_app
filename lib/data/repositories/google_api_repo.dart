import 'package:burger_house/data/models/response_model/places_api_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'google_api_repo.g.dart';

@RestApi()
abstract class GoogleApiRepo {
  factory GoogleApiRepo(Dio dio, {String baseUrl}) = _GoogleApiRepo;

  //get user information
  @GET('/maps/api/place/textsearch/json')
  Future<PlaceApiResponse> getPlaces(
      @DioOptions() dioOptions,
      @Query('query')  String? query,
      @Query('region')  String? region,
      @Query('key')  String? key,
      );
}
