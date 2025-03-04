import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_model.dart';
import 'package:mvvm_architecture_in_flutter/view_models/favorites/favorites_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesProvider, FavoritesState>((ref) {
  return FavoritesProvider();
});

class FavoritesProvider extends StateNotifier<FavoritesState> {
  FavoritesProvider() : super(FavoritesState());

  final favsKey = 'favKey';

  bool isFavorites(MoviesModel moviesModel) {
    return state.favoritesList.any((movie) => movie.id == moviesModel.id);
  }

  Future<void> addOrRemoveFromFavorites(MoviesModel moviesModel) async {
    bool wasFavorite = isFavorites(moviesModel);

    List<MoviesModel> updatedFavorites = wasFavorite
        ? state.favoritesList
            .where((element) => element.id != moviesModel.id)
            .toList()
        : [...state.favoritesList, moviesModel];

    state = state.copyWith(favoritesList: updatedFavorites);
    // if (isFavorites(moviesModel)) {
    //   state.favoritesList.removeWhere((movie) => movie.id == moviesModel.id);
    // } else {
    //   state.favoritesList.add(moviesModel);
    // }
    await saveFavorites();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final stringList = state.favoritesList
        .map((movies) => json.encode(movies.toJson()))
        .toList();
    prefs.setStringList(favsKey, stringList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final stringList = prefs.getStringList(favsKey) ?? [];

    final movies = stringList
        .map((movie) => MoviesModel.fromJson(json.decode(movie)))
        .toList();
    state = state.copyWith(favoritesList: movies);
  }

  void clearAllFavs() {
    state = state.copyWith(favoritesList: []);
    saveFavorites();
  }
}
