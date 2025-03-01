import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider with ChangeNotifier {
  final List<MoviesModel> _favoritesList = [];

  List<MoviesModel> get favoritesList => _favoritesList;

  final favsKey = 'favKey';

  bool isFavorites(MoviesModel moviesModel) {
    return _favoritesList.any((movie) => movie.id == moviesModel.id);
  }

  Future<void> addOrRemoveFromFavorites(MoviesModel moviesModel) async {
    if (isFavorites(moviesModel)) {
      _favoritesList.removeWhere((movie) => movie.id == moviesModel.id);
    } else {
      _favoritesList.add(moviesModel);
    }
    await saveFavorites();
    notifyListeners();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final stringList =
        _favoritesList.map((movies) => json.encode(movies.toJson())).toList();
    prefs.setStringList(favsKey, stringList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final stringList = prefs.getStringList(favsKey) ?? [];

    _favoritesList.clear();
    _favoritesList.addAll(
      stringList.map((movie) => MoviesModel.fromJson(json.decode(movie))),
    );
    notifyListeners();
  }

  void clearAllFavs() {
    _favoritesList.clear();
    notifyListeners();
    saveFavorites();
  }
}
