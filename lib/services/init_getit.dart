import 'package:get_it/get_it.dart';
import 'package:mvvm_architecture_in_flutter/repository/movies_repo.dart';
import 'package:mvvm_architecture_in_flutter/services/api_service.dart';
import 'package:mvvm_architecture_in_flutter/services/navigation_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<NavigationService>(
    () => NavigationService(),
  );
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<MoviesRepository>(() => MoviesRepository(
        getIt<ApiService>(),
      ));
}
