import 'package:burger_house/data/models/request_models/add_address_requesst.dart';
import 'package:burger_house/data/models/request_models/add_card_request.dart';
import 'package:burger_house/data/models/request_models/add_user_request.dart';
import 'package:burger_house/data/models/response_model/card_response.dart';
import 'package:burger_house/data/models/response_model/user_response_model.dart';
import 'package:burger_house/models/address.dart';
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

  //get user information
  @GET('/users/addresses')
  Future<List<Address>> getMyAddresses(
      @DioOptions() dioOptions);

  //get user information
  @DELETE('/users/addresses/{id}')
  Future deleteAddresses(
      @Path('id') addressId
      );

  //add new address user
  @POST('/users/cards')
  Future<Address> addNewAddress(
      @Body() AddAddressRequest userRequest);



  @GET('/users/cards')
  Future<List<CardResponse>> getMyCards(
      @DioOptions() dioOptions);

  @DELETE('/users/cards/{id}')
  Future deleteCards(
      @Path('id') addressId
      );

  @POST('/users/cards')
  Future<CardResponse> addNewCards(
      @Body() AddCardRequest cardRequest);




}
