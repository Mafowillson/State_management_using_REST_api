import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_app_icons.dart';
import 'package:mvvm_architecture_in_flutter/view_models/favorites/favorites_provider.dart';
import 'package:mvvm_architecture_in_flutter/widgets/movies/movies_widget.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteState = ref.watch(favoritesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(favoritesProvider.notifier).clearAllFavs();
            },
            icon: const Icon(
              MyAppIcons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: favoriteState.favoritesList.isEmpty
          ? Center(
              child: Text(
                'No added Favorites!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          : ListView.builder(
              itemCount: favoriteState.favoritesList.length,
              itemBuilder: (context, index) {
                return MoviesWidget(
                  moviesModel:
                      favoriteState.favoritesList.reversed.toList()[index],
                );
              },
            ),
    );
  }
}
