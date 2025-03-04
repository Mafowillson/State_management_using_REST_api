import 'package:mvvm_architecture_in_flutter/models/movies_genres.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_model.dart';

class MoviesState {
  final int currentPage;

  final List<MoviesModel> moviesList;

  final List<MoviesGenres> genresList;

  final bool isLoading;

  final String fetchMoviesError;

  MoviesState({
    this.currentPage = 1,
    this.moviesList = const [],
    this.genresList = const [],
    this.isLoading = false,
    this.fetchMoviesError = '',
  });

  MoviesState copyWith({
    int? currentPage,
    List<MoviesModel>? moviesList,
    List<MoviesGenres>? genresList,
    bool? isLoading,
    String? fetchMoviesError,
  }) {
    return MoviesState(
      currentPage: currentPage ?? this.currentPage,
      moviesList: moviesList ?? this.moviesList,
      genresList: genresList ?? this.genresList,
      isLoading: isLoading ?? this.isLoading,
      fetchMoviesError: fetchMoviesError ?? this.fetchMoviesError,
    );
  }
}
