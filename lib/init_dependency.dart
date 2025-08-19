
import 'package:get_it/get_it.dart';



final serviceLocator = GetIt.instance;



// Future<void> initDependencies() async {
//   // Dependencies
//   serviceLocator.registerLazySingleton(() => AudioBookDataService.instanceFor(AppServices.apiClient));
//   _authServiceDI();
//   _audioBookServiceDI();
//   //
//   // Call essential service initialization
//   await AppServices.init();
// }


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

