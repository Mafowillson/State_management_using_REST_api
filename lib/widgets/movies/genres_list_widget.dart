import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_genres.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_model.dart';
import 'package:mvvm_architecture_in_flutter/utils/genre_utils.dart';

class GenreListWidget extends ConsumerWidget {
  final MoviesModel moviesModel;
  const GenreListWidget({
    super.key,
    required this.moviesModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<MoviesGenres> moviesGenre =
        GenreUtils.movieGenresNames(moviesModel.genreIds, ref);
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
