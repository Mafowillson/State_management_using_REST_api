import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_architecture_in_flutter/view_models/movies/movies_provider.dart';

import '../models/movies_genres.dart';

class GenreUtils {
  static List<MoviesGenres> movieGenresNames(
      List<int> genreIds, WidgetRef ref) {
    final moviesstate = ref.watch(moviesProvider);
    final cachedGenres = moviesstate.genresList;

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
