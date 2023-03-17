import 'package:burger_house/data/repositories/authenication_repo.dart';
import 'package:burger_house/data/repositories/google_api_repo.dart';
import 'package:burger_house/data/repositories/menu_repo.dart';
import 'package:burger_house/data/repositories/order_repo.dart';
import 'package:burger_house/data/repositories/user_repo.dart';
import 'package:burger_house/utils/env.dart';
import 'package:get_it/get_it.dart';

import 'http/dio_client.dart';

class RepositoryRegistry {
  DioClient dioClient = DioClient();
  DioClient dioClientPublic = DioClient();

  RepositoryRegistry(GetIt locator, {testing}) {
    if(!testing) {
      locator.registerLazySingleton<AuthenticationRepo>(() =>
          AuthenticationRepo(
              dioClient.getClient(),
              baseUrl: Env.get(EnvKey.BASE_URL)!));
      locator.registerLazySingleton<UserRepo>(() =>
          UserRepo(
              dioClient.getClient(),
              baseUrl: Env.get(EnvKey.BASE_URL)!));
      locator.registerLazySingleton<MenuRepo>(() =>
          MenuRepo(
              dioClient.getClient(),
              baseUrl: Env.get(EnvKey.BASE_URL)!));
      locator.registerLazySingleton<OrderRepo>(() =>
          OrderRepo(
              dioClient.getClient(),
              baseUrl: Env.get(EnvKey.BASE_URL)!));
      locator.registerLazySingleton<GoogleApiRepo>(() =>
          GoogleApiRepo(
              dioClientPublic.getClient(needsAuth: false),
              baseUrl: Env.get(EnvKey.GOOGLE_API_BASE_URL)!));


      locator.registerLazySingleton<DioClient>(() => dioClient);

    }
  }
}
