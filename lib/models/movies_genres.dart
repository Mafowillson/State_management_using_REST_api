import 'package:equatable/equatable.dart';

class MoviesGenres extends Equatable {
  final int id;
  final String name;

  const MoviesGenres({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];

  factory MoviesGenres.fromJson(Map<String, dynamic> json) {
    return MoviesGenres(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'MoviesGenres(id: $id, name: $name)';
  }
}
