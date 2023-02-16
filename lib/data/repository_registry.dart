import 'package:burger_house/data/repositories/authenication_repo.dart';
import 'package:burger_house/utils/env.dart';
import 'package:get_it/get_it.dart';

import 'http/dio_client.dart';

class RepositoryRegistry {
  DioClient dioClient = DioClient();

  RepositoryRegistry(GetIt locator, {testing}) {
    if(!testing) {
      locator.registerLazySingleton<AuthenticationRepo>(() =>
          AuthenticationRepo(
              dioClient.getClient(),
              baseUrl: Env.get(EnvKey.BASE_URL)!));

      locator.registerLazySingleton<DioClient>(() => dioClient);

    }
  }
}
