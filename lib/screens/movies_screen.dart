import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_app_icons.dart';
import 'package:mvvm_architecture_in_flutter/screens/favorites_screen.dart';
import 'package:mvvm_architecture_in_flutter/services/init_getit.dart';
import 'package:mvvm_architecture_in_flutter/services/navigation_service.dart';
import 'package:mvvm_architecture_in_flutter/view_models/theme/theme_bloc.dart';
import 'package:mvvm_architecture_in_flutter/widgets/movies/movies_widget.dart';

import '../view_models/movies/movies_bloc.dart';
// import 'dart:developer' as devtool;

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        actions: [
          IconButton(
            onPressed: () {
              //getIt<NavigationService>().showSnackbar();
              // .navigate(
              //   FavoritesScreen(),
              // );
              getIt<NavigationService>().navigate(FavoritesScreen());
            },
            icon: const Icon(
              MyAppIcons.favorite,
              color: Colors.red,
            ),
          ),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  // context.read<ThemeBloc>().add(ToggleThemeEvent());
                  getIt<ThemeBloc>().add(ToggleThemeEvent());
                },
                icon: Icon(
                  state is DarkThemeState
                      ? MyAppIcons.darkMode
                      : MyAppIcons.lightMode,
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoadingState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is MoviesErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is MoviesLoadedState ||
              state is MoviesLoadingMoreState) {
            final movies = state is MoviesLoadedState
                ? state.moviesList
                : (state as MoviesLoadingMoreState).moviesList;

            bool isLoadingMore = state is MoviesLoadingMoreState;
            int itemCount = isLoadingMore ? movies.length + 1 : movies.length;
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    !isLoadingMore) {
                  getIt<MoviesBloc>().add(FetchMoreMoviesEvent());
                  return true;
                }
                return false;
              },
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  if (index >= movies.length && isLoadingMore) {
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  }
                  return MoviesWidget(moviesModel: movies[index]);
                },
              ),
            );
          }
          return const Center(
            child: Text('No data available'),
          );
        },
      ),
    );
  }
}
