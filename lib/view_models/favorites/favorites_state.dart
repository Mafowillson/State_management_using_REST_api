import 'package:mvvm_architecture_in_flutter/models/movies_model.dart';

class FavoritesState {
  final List<MoviesModel> favoritesList;

  FavoritesState({
    this.favoritesList = const [],
  });

  FavoritesState copyWith({
    List<MoviesModel>? favoritesList,
  }) {
    return FavoritesState(
      favoritesList: favoritesList ?? this.favoritesList,
    );
  }
}
