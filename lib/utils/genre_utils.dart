import 'package:flutter/material.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_genres.dart';
import 'package:mvvm_architecture_in_flutter/view_medels/movies_provider.dart';
import 'package:provider/provider.dart';

class GenreUtils {
  static List<MoviesGenres> movieGenresNames(
      List<int> genreIds, BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    final cachedGenres = moviesProvider.genresList;

    List<MoviesGenres> genresNames = [];

    for (var genreId in genreIds) {
      var genre = cachedGenres.firstWhere(
        (g) => g.id == genreId,
        orElse: () => MoviesGenres(id: 5448484, name: 'Unknown'),
      );
      genresNames.add(genre);
    }
    return genresNames;
  }
}
