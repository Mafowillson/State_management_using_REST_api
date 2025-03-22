import 'package:mvvm_architecture_in_flutter/models/movies_genres.dart';

class GenreUtils {
  static List<MoviesGenres> movieGenresNames(
    List<int> moviesGenreIds,
    List<MoviesGenres> allGenreList,
  ) {
    List<MoviesGenres> genresNames = [];

    for (var genreId in moviesGenreIds) {
      var genre = allGenreList.firstWhere(
        (g) => g.id == genreId,
        orElse: () => MoviesGenres(id: 5448484, name: 'Unknown'),
      );
      genresNames.add(genre);
    }
    return genresNames;
  }
}
