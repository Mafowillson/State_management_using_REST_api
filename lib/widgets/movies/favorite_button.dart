import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_app_icons.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_model.dart';
import 'package:mvvm_architecture_in_flutter/view_models/favorites/favorites_provider.dart';

class FavoriteButtonWidget extends ConsumerWidget {
  const FavoriteButtonWidget({super.key, required this.moviesModel});
  final MoviesModel moviesModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Dont do this!!!!
    // final favoritesState = ref.read(favoritesProvider);
    //Do this instead!
    final favoritesList =
        ref.watch(favoritesProvider.select((state) => state.favoritesList));
    final isFavorite = favoritesList.any((movie) => movie.id == moviesModel.id);
    return IconButton(
      onPressed: () {
        //Todo: implement add to favorite
        ref
            .read(favoritesProvider.notifier)
            .addOrRemoveFromFavorites(moviesModel);
      },
      icon: Icon(
        isFavorite ? MyAppIcons.favorite : MyAppIcons.facoriteOutlineRounded,
        color:
            isFavorite ? Colors.red : null, // isFavorite ? Colors.red : null,
        //color: Colors.red,
        size: 20,
      ),
    );
  }
}
