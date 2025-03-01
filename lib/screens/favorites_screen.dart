import 'package:flutter/material.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_app_icons.dart';
import 'package:mvvm_architecture_in_flutter/view_medels/favorites_provider.dart';
import 'package:mvvm_architecture_in_flutter/widgets/movies/movies_widget.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoritesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
        actions: [
          IconButton(
            onPressed: () {
              favoriteProvider.clearAllFavs();
            },
            icon: const Icon(
              MyAppIcons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: favoriteProvider.favoritesList.isEmpty
          ? Center(
              child: Text(
                'No added Favorites!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          : ListView.builder(
              itemCount: favoriteProvider.favoritesList.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value:
                      favoriteProvider.favoritesList.reversed.toList()[index],
                  child: MoviesWidget(),
                );
              },
            ),
    );
  }
}
