import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_genres.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_model.dart';
import 'package:mvvm_architecture_in_flutter/repository/movies_repo.dart';
import 'package:mvvm_architecture_in_flutter/services/init_getit.dart';

class MoviesProvider with ChangeNotifier {
  int _currentPage = 1;

  final List<MoviesModel> _moviesList = [];

  List<MoviesModel> get moviesList => _moviesList;

  List<MoviesGenres> _generesList = [];

  List<MoviesGenres> get genresList => _generesList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _fetchMoviesError = '';
  String get fetchMoviesError => _fetchMoviesError;

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();

  Future<void> getMovies() async {
    _isLoading = true;
    //notifyListeners();
    try {
      if (_generesList.isEmpty) {
        _generesList = await _moviesRepository.fetchGenres();
      }
      List<MoviesModel> movies =
          await _moviesRepository.fetchMovies(page: _currentPage);
      _moviesList.addAll(movies);
      _currentPage++;
      _fetchMoviesError = '';
    } catch (error) {
      log('An error occured in fetch movies $error');
      _fetchMoviesError = error.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
