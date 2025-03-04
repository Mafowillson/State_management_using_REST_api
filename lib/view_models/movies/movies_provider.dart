import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_architecture_in_flutter/services/init_getit.dart';
import 'package:mvvm_architecture_in_flutter/view_models/movies/movies_state.dart';

import '../../models/movies_model.dart';
import '../../repository/movies_repo.dart';

final moviesProvider =
    StateNotifierProvider<MoviesProvider, MoviesState>((ref) {
  return MoviesProvider();
});

final currentMovie = Provider.family<MoviesModel, int>((ref, index) {
  final moviesState = ref.watch(moviesProvider);
  return moviesState.moviesList[index];
});

class MoviesProvider extends StateNotifier<MoviesState> {
  MoviesProvider() : super(MoviesState());

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();

  Future<void> getMovies() async {
    // log('get movies called');
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);
    // log('getmovies continued execution...');
    try {
      if (state.genresList.isEmpty) {
        final generesList = await _moviesRepository.fetchGenres();
        state = state.copyWith(genresList: generesList);
      }
      List<MoviesModel> movies =
          await _moviesRepository.fetchMovies(page: state.currentPage);
      state = state.copyWith(
        moviesList: [...state.moviesList, ...movies],
        currentPage: state.currentPage + 1,
        fetchMoviesError: '',
        isLoading: false,
      );
      // log('current page: ${state.currentPage}');
    } catch (e) {
      state = state.copyWith(fetchMoviesError: e.toString(), isLoading: false);
      rethrow;
    }
  }
}
