
import 'package:burger_house/data/models/request_models/order_request_model.dart';
import 'package:burger_house/data/models/response_model/order_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'order_repo.g.dart';

@RestApi()
abstract class OrderRepo {
  factory OrderRepo(Dio dio, {String baseUrl}) = _OrderRepo;

  @POST('/orders')
  Future<Order> createOrder(
      @DioOptions() dioOptions,
        @Body()  OrderRequest orderRequest,
  );

  @GET('/orders')
  Future<List<Order>> getOrders(
      @DioOptions() dioOptions,
  );


  @POST('/orders/{id}/verify')
  Future<Order> verifyOrder(
        @Path('id') String id,
  );


}
