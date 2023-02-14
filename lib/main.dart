import 'package:burger_house/app.dart';
import 'package:burger_house/data/http/dio_client.dart';
import 'package:burger_house/data/http/inteceptors/api_cache_interceptor.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/services/global_notification.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/utils/env.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Helper.logger.i('Initializing Data');

  //init cache lay for dio http caching
  await CacheService.init();

  //init depcency finder service
  await ServiceLocator.register();
  //trigger warming of global stream notifer
  ServiceLocator.locator<GlobalNotificationService>();

  //create navigation routes
  AppRoutes.createRoutes();
  await Env.load();

  //need dio database path before registering repos
  await DioClient.initGetDBPath();
  Helper.logger.i('Initializing Completed');

  runApp(const MyApp());
}

