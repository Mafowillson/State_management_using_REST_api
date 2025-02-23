import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mvvm_architecture_in_flutter/constants/api_constants.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_genres.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_model.dart';
//import 'dart:developer' as devtool;

class ApiService {
  Future<List<MoviesModel>> fetchMovies({int page = 1}) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}/movie/popular?language=en-US&page=$page');
    final response = await http.get(url, headers: ApiConstants.headers).timeout(
          Duration(
            seconds: 10,
          ),
        );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // devtool.log('data $data');
      return List.from(
          data['results'].map((element) => MoviesModel.fromJson(element)));
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }

  Future<List<MoviesGenres>> fetchGenres() async {
    final url =
        Uri.parse('${ApiConstants.baseUrl}/genre/movie/list?language=en');
    final response = await http.get(url, headers: ApiConstants.headers).timeout(
          Duration(
            seconds: 10,
          ),
        );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // devtool.log('data $data');
      return List.from(
          data['genres'].map((element) => MoviesGenres.fromJson(element)));
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }
}
