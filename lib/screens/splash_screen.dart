import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_architecture_in_flutter/screens/movies_screen.dart';
import 'package:mvvm_architecture_in_flutter/services/init_getit.dart';
import 'package:mvvm_architecture_in_flutter/services/navigation_service.dart';
import 'package:mvvm_architecture_in_flutter/widgets/my_error_widget.dart';

import '../view_models/favorites/favorites_bloc.dart';
import '../view_models/movies/movies_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesBloc = getIt<MoviesBloc>();
    final favoriteBloc = getIt<FavoritesBloc>();

    final navigationService = getIt<NavigationService>();
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<MoviesBloc, MoviesState>(
            bloc: moviesBloc..add(FetchMoviesEvent()),
            listener: (context, state) {
              if (state is MoviesLoadedState &&
                  favoriteBloc.state is FavoritesLoaded) {
                navigationService.navigateReplace(MoviesScreen());
              } else if (state is MoviesErrorState) {
                navigationService.showSnackbar(state.message);
              }
            },
          ),
          BlocListener<FavoritesBloc, FavoritesState>(
            bloc: favoriteBloc..add(LoadFavorites()),
            listener: (context, state) {
              if (state is FavoritesError) {
                navigationService.showSnackbar(state.message);
              }
            },
          ),
        ],
        child: BlocBuilder<MoviesBloc, MoviesState>(
          bloc: moviesBloc..add(FetchMoviesEvent()),
          builder: (context, state) {
            if (state is MoviesLoadingState) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Loading...'),
                    SizedBox(height: 20),
                    CircularProgressIndicator.adaptive(),
                  ],
                ),
              );
            } else if (state is MoviesErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyErrorWidget(
                      errorText: state.message,
                      retyFunction: () {
                        moviesBloc.add(FetchMoviesEvent());
                      },
                    ),
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
