import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_app_icons.dart';
import 'package:mvvm_architecture_in_flutter/enums/theme_enums.dart';
import 'package:mvvm_architecture_in_flutter/screens/favorites_screen.dart';
import 'package:mvvm_architecture_in_flutter/services/init_getit.dart';
import 'package:mvvm_architecture_in_flutter/services/navigation_service.dart';
import 'package:mvvm_architecture_in_flutter/view_models/movies/movies_provider.dart';
import 'package:mvvm_architecture_in_flutter/widgets/movies/movies_widget.dart';

import '../view_models/theme_provider.dart';

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
          Consumer(builder: (context, ref, child) {
            final themeState = ref.watch(themeProvider);
            return IconButton(
              onPressed: () async {
                await ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: Icon(
                themeState == ThemeEnums.dark
                    ? MyAppIcons.darkMode
                    : MyAppIcons.lightMode,
              ),
            );
          }),
        ],
      ),
      body: Consumer(builder: (context, WidgetRef ref, child) {
        final moviesState = ref.watch(moviesProvider);
        if (moviesState.isLoading && moviesState.moviesList.isEmpty) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (moviesState.fetchMoviesError.isNotEmpty) {
          return Center(
            child: Text(moviesState.fetchMoviesError),
          );
        }
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                !moviesState.isLoading) {
              ref.read(moviesProvider.notifier).getMovies();
              return true;
            }
            return false;
          },
          child: ListView.builder(
            itemCount: moviesState.moviesList.length,
            itemBuilder: (context, index) {
              return MoviesWidget(
                moviesModel: moviesState.moviesList[index],
              );
            },
          ),
        );
      }),
    );
  }
}
