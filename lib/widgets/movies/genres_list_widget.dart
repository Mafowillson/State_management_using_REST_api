import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_genres.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_model.dart';
import 'package:mvvm_architecture_in_flutter/utils/genre_utils.dart';

import '../../view_models/movies/movies_bloc.dart';

class GenreListWidget extends StatelessWidget {
  const GenreListWidget({
    super.key,
    required this.moviesModel,
  });
  final MoviesModel moviesModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoadedState || state is MoviesLoadingMoreState) {
          List<MoviesGenres> moviesGenre = GenreUtils.movieGenresNames(
              moviesModel.genreIds,
              state is MoviesLoadedState
                  ? state.genresList
                  : (state as MoviesLoadingMoreState).genresList);
          return Wrap(
            children: List.generate(
              moviesGenre.length,
              (index) => chipWidget(
                genreName: moviesGenre[index].name,
                context: context,
              ),
            ),
          );
        }
        return const Text('Loading genres...');
      },
    );
  }

  Widget chipWidget({
    required String genreName,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.surface.withValues(),
          border: Border.all(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 2,
          ),
          child: Text(
            genreName,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
