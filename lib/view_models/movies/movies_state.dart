part of 'movies_bloc.dart';

sealed class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

final class MoviesInitial extends MoviesState {}

final class MoviesLoadingState extends MoviesState {}

final class MoviesLoadedState extends MoviesState {
  final int currentPage;

  final List<MoviesModel> moviesList;

  final List<MoviesGenres> genresList;

  const MoviesLoadedState({
    this.currentPage = 0,
    this.moviesList = const [],
    this.genresList = const [],
  });

  @override
  List<Object> get props => [moviesList, genresList, currentPage];
}

final class MoviesLoadingMoreState extends MoviesState {
  final int currentPage;

  final List<MoviesModel> moviesList;

  final List<MoviesGenres> genresList;

  const MoviesLoadingMoreState({
    this.currentPage = 0,
    this.moviesList = const [],
    this.genresList = const [],
  });

  @override
  List<Object> get props => [moviesList, genresList, currentPage];
}

final class MoviesErrorState extends MoviesState {
  final String message;

  const MoviesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
