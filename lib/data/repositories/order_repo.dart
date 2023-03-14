
import 'package:burger_house/data/models/request_models/order_request_model.dart';
import 'package:burger_house/data/models/response_model/order_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'order_repo.g.dart';

@RestApi()
abstract class OrderRepo {
  factory OrderRepo(Dio dio, {String baseUrl}) = _OrderRepo;

  @POST('/orders')
  Future<Order> getFeeEstimate(
      @DioOptions() dioOptions,
        @Body()  OrderRequest orderRequest,
  );


}
