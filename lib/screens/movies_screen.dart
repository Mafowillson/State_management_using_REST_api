import 'package:flutter/material.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_app_icons.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_genres.dart';
import 'package:mvvm_architecture_in_flutter/repository/movies_repo.dart';
import 'package:mvvm_architecture_in_flutter/screens/favorites_screen.dart';
import 'package:mvvm_architecture_in_flutter/services/init_getit.dart';
import 'package:mvvm_architecture_in_flutter/services/navigation_service.dart';
import 'package:mvvm_architecture_in_flutter/widgets/movies/movies_widget.dart';
import 'dart:developer' as devtool;

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
          IconButton(
            onPressed: () async {
              // List<MoviesModel> movies =
              //     await getIt<ApiService>().fetchMovies();
              // devtool.log('movies $movies');

              List<MoviesGenres> movies =
                  //await getIt<ApiService>().fetchGenres();
                  await getIt<MoviesRepository>().fetchGenres();
              devtool.log('Genres $movies');
            },
            icon: const Icon(
              MyAppIcons.darkMode,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MoviesWidget(),
          );
        },
      ),
    );
  }
}
