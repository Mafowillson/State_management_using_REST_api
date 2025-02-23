class MoviesGenres {
  final int id;
  final String name;

  MoviesGenres({
    required this.id,
    required this.name,
  });

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
