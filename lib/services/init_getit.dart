import 'package:get_it/get_it.dart';
import 'package:mvvm_architecture_in_flutter/repository/movies_repo.dart';
import 'package:mvvm_architecture_in_flutter/services/api_service.dart';
import 'package:mvvm_architecture_in_flutter/services/navigation_service.dart';
import 'package:mvvm_architecture_in_flutter/view_models/favorites/favorites_bloc.dart';
import 'package:mvvm_architecture_in_flutter/view_models/movies/movies_bloc.dart';
import 'package:mvvm_architecture_in_flutter/view_models/theme/theme_bloc.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<NavigationService>(
    () => NavigationService(),
  );
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<MoviesRepository>(() => MoviesRepository(
        getIt<ApiService>(),
      ));
  getIt.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
  getIt.registerLazySingleton<MoviesBloc>(() => MoviesBloc());
  getIt.registerLazySingleton<FavoritesBloc>(() => FavoritesBloc());
}
