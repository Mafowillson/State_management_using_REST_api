part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class AddToFavorites extends FavoritesEvent {
  final MoviesModel moviesModel;

  const AddToFavorites({required this.moviesModel});
  @override
  List<Object> get props => [moviesModel];
}

class RemoveFromFavorites extends FavoritesEvent {
  final MoviesModel moviesModel;

  const RemoveFromFavorites({required this.moviesModel});

  @override
  List<Object> get props => [moviesModel];
}

class RemoveAllFromFavorites extends FavoritesEvent {}
