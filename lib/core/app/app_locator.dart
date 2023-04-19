import 'package:firebase_login_authentication/core/services/network_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
// Register dependencies

  locator.registerLazySingleton<NetworkServiceRepository>(
      () => NetworkServiceRepositoryImpl());
}
