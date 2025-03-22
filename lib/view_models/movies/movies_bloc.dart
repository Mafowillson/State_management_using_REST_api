// import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/movies_genres.dart';
import '../../models/movies_model.dart';
import '../../repository/movies_repo.dart';
import '../../services/init_getit.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<FetchMoviesEvent>(_onFetchMovies);
    on<FetchMoreMoviesEvent>(_onFetchMoreMovies);
  }

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();
  Future<void> _onFetchMovies(event, emit) async {
    emit(MoviesLoadingState());
    try {
      var genres = await _moviesRepository.fetchGenres();
      // log('genre lenth ${genres.length}');
      var movies = await _moviesRepository.fetchMovies(page: 1);

      emit(MoviesLoadedState(
        currentPage: 1,
        genresList: genres,
        moviesList: movies,
      ));
    } catch (e) {
      emit(MoviesErrorState(message: 'Failed to Load movies $e'));
    }
  }

  Future<void> _onFetchMoreMovies(event, emit) async {
    final currentState = state;

    if (currentState is MoviesLoadingMoreState) {
      return;
    }

    if (currentState is! MoviesLoadedState) {
      return;
    }
    emit(MoviesLoadingMoreState(
      currentPage: currentState.currentPage,
      genresList: currentState.genresList,
      moviesList: currentState.moviesList,
    ));

    try {
      List<MoviesModel> movies = await _moviesRepository.fetchMovies(
          page: currentState.currentPage + 1);
      if (movies.isEmpty) {
        emit(currentState);
        return;
      }
      currentState.moviesList.addAll(movies);
      emit(MoviesLoadedState(
        currentPage: currentState.currentPage + 1,
        genresList: currentState.genresList,
        moviesList: currentState.moviesList,
      ));
    } catch (e) {
      emit(MoviesErrorState(message: 'Failed to Load movies $e'));
    }
  }
}
