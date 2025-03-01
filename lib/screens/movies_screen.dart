import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_app_icons.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_them_data.dart';
import 'package:mvvm_architecture_in_flutter/screens/favorites_screen.dart';
import 'package:mvvm_architecture_in_flutter/services/init_getit.dart';
import 'package:mvvm_architecture_in_flutter/services/navigation_service.dart';
import 'package:mvvm_architecture_in_flutter/view_medels/movies_provider.dart';
import 'package:mvvm_architecture_in_flutter/view_medels/theme_provider.dart';
import 'package:mvvm_architecture_in_flutter/widgets/movies/movies_widget.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    log('Build Rebuild');
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
          Consumer(
            builder: (context, ThemeProvider themeProvider, child) {
              return IconButton(
                onPressed: () async {
                  themeProvider.toggleTheme();
                  // List<MoviesModel> movies =
                  //     await getIt<ApiService>().fetchMovies();
                  // devtool.log('movies $movies');

                  // List<MoviesGenres> movies =
                  //     //await getIt<ApiService>().fetchGenres();
                  //     await getIt<MoviesRepository>().fetchGenres();
                  // devtool.log('Genres $movies');
                },
                icon: Icon(
                  themeProvider.themeData == MyThemData.darkTheme
                      ? MyAppIcons.darkMode
                      : MyAppIcons.lightMode,
                ),
              );
            },
            //child: Text("Theme mode"),
          ),
        ],
      ),
      body: Consumer<MoviesProvider>(builder: (context, moviesProvider, child) {
        if (moviesProvider.isLoading && moviesProvider.moviesList.isEmpty) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (moviesProvider.fetchMoviesError.isNotEmpty) {
          return Center(
            child: Text(moviesProvider.fetchMoviesError),
          );
        }
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                !moviesProvider.isLoading) {
              moviesProvider.getMovies();
              return true;
            }
            return false;
          },
          child: ListView.builder(
            itemCount: moviesProvider.moviesList.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: moviesProvider.moviesList[index],
                child: MoviesWidget(),
              );
            },
          ),
        );
      }),
    );
  }
}
