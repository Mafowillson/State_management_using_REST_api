import 'package:flutter/material.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_app_icons.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_model.dart';

class FavoriteButtonWidget extends StatefulWidget {
  const FavoriteButtonWidget({super.key, required this.moviesModel});
  final MoviesModel moviesModel;

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  final favoriteMoviesIds = [];
  @override
  Widget build(BuildContext context) {
    bool isFavorite = favoriteMoviesIds.contains(widget.moviesModel.id);
    return IconButton(
      onPressed: () {
        if (isFavorite) {
          favoriteMoviesIds.remove(widget.moviesModel.id);
        } else {
          favoriteMoviesIds.add(widget.moviesModel.id);
        }
        setState(() {});
      },
      icon: Icon(
        isFavorite ? MyAppIcons.favorite : MyAppIcons.facoriteOutlineRounded,
        color: isFavorite ? Colors.red : null,
        //color: Colors.red,
        size: 20,
      ),
    );
  }
}
