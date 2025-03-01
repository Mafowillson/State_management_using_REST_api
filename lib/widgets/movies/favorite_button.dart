import 'package:flutter/material.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_app_icons.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_model.dart';
import 'package:mvvm_architecture_in_flutter/view_medels/favorites_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButtonWidget extends StatelessWidget {
  const FavoriteButtonWidget({super.key, required this.moviesModel});
  final MoviesModel moviesModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
        builder: (context, favoriteProvider, child) {
      return IconButton(
        onPressed: () {
          favoriteProvider.addOrRemoveFromFavorites(moviesModel);
        },
        icon: Icon(
          favoriteProvider.isFavorites(moviesModel)
              ? MyAppIcons.favorite
              : MyAppIcons.facoriteOutlineRounded,
          color: favoriteProvider.isFavorites(moviesModel)
              ? Colors.red
              : null, // isFavorite ? Colors.red : null,
          //color: Colors.red,
          size: 20,
        ),
      );
    });
  }
}
