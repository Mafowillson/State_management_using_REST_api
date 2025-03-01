import 'package:mvvm_architecture_in_flutter/models/movies_genres.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_model.dart';
import 'package:mvvm_architecture_in_flutter/services/api_service.dart';

class MoviesRepository {
  final ApiService _apiService;
  MoviesRepository(this._apiService);

  Future<List<MoviesModel>> fetchMovies({int page = 1}) async {
    return await _apiService.fetchMovies(page: page);
  }

  // List<MoviesGenres> cachedGenres = [];
  Future<List<MoviesGenres>> fetchGenres() async {
    // return cachedGenres = await _apiService.fetchGenres();
    return await _apiService.fetchGenres();
  }
}
