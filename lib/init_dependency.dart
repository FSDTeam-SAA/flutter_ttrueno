
import 'package:get_it/get_it.dart';
import 'package:ttrueno_fo827e642a0c4/modules/auth/service/auth_interface_impl.dart';

import 'core/services/app_services.dart';
import 'modules/auth/interface/auth_inerface.dart';



final serviceLocator = GetIt.instance;



Future<void> initDependencies() async {
  // Dependencies
  serviceLocator.registerFactory<AuthInterface>(
    () => AuthInterfaceImpl(AppServices.apiClient, AppServices.authService),
  );
  //
  // Call essential service initialization
  await AppServices.coreInit();
}


// void _audioBookServiceDI() {
//   //::: Remote Datasource [register singletone]
//   serviceLocator.registerLazySingleton<AudioBookRemoteDatasource>(
//     () => AudioBookRemoteDatasourceImpl(serviceLocator<AudioBookDataService>()),
//   );
//   //::: Local Datasource [register singletone]

//   //::: Repo [register factory]
//   serviceLocator.registerFactory<AudioBookRepo>(
//     () => AudioBookRepoImpl(serviceLocator<AudioBookRemoteDatasource>()),
//   );

//   //::: Usecases
//   serviceLocator.registerLazySingleton(
//     () => GetAudioBooks(serviceLocator<AudioBookRepo>()),
//   );
//   serviceLocator.registerLazySingleton(
//     () => GetAudioUrl(serviceLocator<AudioBookRepo>()),
//   );
//   serviceLocator.registerLazySingleton(
//     () => GetLibraryAudios(serviceLocator<AudioBookRepo>()),
//   );
//   serviceLocator.registerLazySingleton(
//     () => SingleAudioBook(serviceLocator<AudioBookRepo>()),
//   );
//   serviceLocator.registerLazySingleton(
//     () => GetCategories(serviceLocator<AudioBookRepo>()),
//   );
//   serviceLocator.registerLazySingleton(
//     () => GetCategoriesAudioBooks(serviceLocator<AudioBookRepo>()),
//   );
//   serviceLocator.registerLazySingleton(
//     () => FilterAudioBooks(serviceLocator<AudioBookRepo>()),
//   );
// }

