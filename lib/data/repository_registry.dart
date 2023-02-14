import 'package:get_it/get_it.dart';

import '../utils/env.dart';
import 'http/dio_client.dart';

class RepositoryRegistry {
  DioClient dioClient = DioClient();

  RepositoryRegistry(GetIt locator, {testing}) {
    if(!testing) {
      // locator.registerLazySingleton<PostRepo>(() =>
      //     PostRepo(
      //         dioClient.getClient(),
      //         baseUrl: Encrypt.decrypt(Env.get(EnvKey.TIME_ZONE)!)));

      locator.registerLazySingleton<DioClient>(() => dioClient);


    }
  }
}
