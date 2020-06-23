import 'package:get_it/get_it.dart';
import 'Services/fcm_services.dart';
import 'Services/navigation_services.dart';
import 'Services/storageService.dart';
import 'Services/firestore_services.dart';
import 'Services/dialog_services.dart';
import 'Services/authentication_services.dart';

GetIt locator =GetIt.instance;

void setupLocator(){


  locator.registerLazySingleton<AuthenticationService>(()=>AuthenticationService());
  locator.registerLazySingleton<FirestoreServiceAPI>(()=>FirestoreServiceAPI());
  locator.registerLazySingleton<RoutingService>(()=>RoutingService());
  locator.registerLazySingleton<FcmServices>(()=>FcmServices());
  locator.registerLazySingleton<DialogService>(()=>DialogService());

  //  locator.registerLazySingleton(()=>StorageService());
  //  locator.registerLazySingleton(()=>DialogService());

  //  locator.registerSingleton<UserController>(UserController());
  //  locator.registerSingleton<CrudModel>(CrudModel());
}
