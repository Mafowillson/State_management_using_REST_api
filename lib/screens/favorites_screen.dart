import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_app_icons.dart';
import 'package:mvvm_architecture_in_flutter/services/init_getit.dart';
import 'package:mvvm_architecture_in_flutter/widgets/movies/movies_widget.dart';
import 'package:mvvm_architecture_in_flutter/widgets/my_error_widget.dart';

import '../view_models/favorites/favorites_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
        actions: [
          IconButton(
            onPressed: () {
              getIt<FavoritesBloc>().add(RemoveAllFromFavorites());
            },
            icon: const Icon(
              MyAppIcons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is FavoritesError) {
            return MyErrorWidget(
                errorText: state.message,
                retyFunction: () {
                  getIt<FavoritesBloc>().add(LoadFavorites());
                });
          } else if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return const Center(
                child: Text(
                  'No favorites has been added yet!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                return MoviesWidget(
                    moviesModel: state.favorites.reversed.toList()[index]);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
