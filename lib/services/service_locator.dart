import 'package:burger_house/models/cart.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:get_it/get_it.dart';
import '../data/repository_registry.dart';
import '../utils/local_storage.dart';
import '../utils/secure_storage.dart';
import 'global_notification.dart';

class ServiceLocator {
  static final locator = GetIt.instance;
  ServiceLocator._();
  static Future<void> register({testing = false}) async {
    var localStorage = await LocalStorage.create();
    final initFuture = FlutterLibphonenumber();
    await initFuture.init();
    RepositoryRegistry(locator,testing: testing);


    locator.registerLazySingleton<LocalStorage>(() => localStorage);
    locator.registerLazySingleton<Cart>(() => Cart());
    locator.registerLazySingleton<GlobalNotificationService>(() => GlobalNotificationService());
    locator.registerLazySingleton<SecureStore>(() => SecureStore.init());
    locator.registerLazySingleton<FlutterLibphonenumber>(() => initFuture);

  }
}
