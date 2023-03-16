
import 'package:burger_house/data/models/response_model/menu_item.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'menu_repo.g.dart';

@RestApi()
abstract class MenuRepo {

  factory MenuRepo(Dio dio, {String baseUrl}) = _MenuRepo;

  //get user information
  @GET('/menus')
  Future<List<MenuItem>> getMenuItems(
      @DioOptions() dioOptions,
      {
        @Query('popular')  bool? isPopular,
        @Query('types')  bool? types,
        @Query('query')  String? searchQuery,
        @Query('category')  String? category,
      }
  );


}
