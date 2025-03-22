import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mvvm_architecture_in_flutter/models/movies_model.dart';
import 'package:mvvm_architecture_in_flutter/services/init_getit.dart';
import 'package:mvvm_architecture_in_flutter/services/navigation_service.dart';
import 'package:mvvm_architecture_in_flutter/view_models/favorites/favorites_bloc.dart';

import '../../constants/my_app_icons.dart';

//The code below has been implemented using the blocConsumer
class FavoriteButtonWidget extends StatelessWidget {
  const FavoriteButtonWidget({
    super.key,
    required this.moviesModel,
  });
  final MoviesModel moviesModel;

  @override
  Widget build(BuildContext context) {
    final navigationService = getIt<NavigationService>();
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        if (state is FavoritesError) {
          navigationService
              .showSnackbar('An error has occured ${state.message}');
        }
      },
      builder: (context, state) {
        bool isFavorite = (state is FavoritesLoaded) &&
            state.favorites.any((movie) => movie.id == moviesModel.id);
        return IconButton(
          onPressed: () {
            //Todo: implement add to favorite
            getIt<FavoritesBloc>().add(
              isFavorite
                  ? RemoveFromFavorites(moviesModel: moviesModel)
                  : AddToFavorites(moviesModel: moviesModel),
            );
            // if (isFavorite) {
            //   getIt<FavoritesBloc>().add(RemoveAllFromFavorites());
            // }
            // {
            //   getIt<FavoritesBloc>()
            //       .add(AddToFavorites(moviesModel: moviesModel));
            // }
          },
          icon: Icon(
            isFavorite
                ? MyAppIcons.favorite
                : MyAppIcons.facoriteOutlineRounded,
            color: isFavorite ? Colors.red : null,
            size: 20,
          ),
        );
      },
    );
  }
}

// This code has been implemeted using the blocBuilder
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:mvvm_architecture_in_flutter/models/movies_model.dart';
// import 'package:mvvm_architecture_in_flutter/services/init_getit.dart';
// import 'package:mvvm_architecture_in_flutter/view_models/favorites/favorites_bloc.dart';

// import '../../constants/my_app_icons.dart';

// class FavoriteButtonWidget extends StatelessWidget {
//   const FavoriteButtonWidget({
//     super.key,
//     required this.moviesModel,
//   });
//   final MoviesModel moviesModel;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FavoritesBloc, FavoritesState>(
//       builder: (context, state) {
//         bool isFavorite = (state is FavoritesLoaded) &&
//             state.favorites.any((movie) => movie.id == moviesModel.id);
//         return IconButton(
//           onPressed: () {
//             //Todo: implement add to favorite
//             getIt<FavoritesBloc>().add(
//               isFavorite
//                   ? RemoveFromFavorites(moviesModel: moviesModel)
//                   : AddToFavorites(moviesModel: moviesModel),
//             );
//             // if (isFavorite) {
//             //   getIt<FavoritesBloc>().add(RemoveAllFromFavorites());
//             // }
//             // {
//             //   getIt<FavoritesBloc>()
//             //       .add(AddToFavorites(moviesModel: moviesModel));
//             // }
//           },
//           icon: Icon(
//             isFavorite
//                 ? MyAppIcons.favorite
//                 : MyAppIcons.facoriteOutlineRounded,
//             color: isFavorite ? Colors.red : null,
//             size: 20,
//           ),
//         );
//       },
//     );
//   }
// }
