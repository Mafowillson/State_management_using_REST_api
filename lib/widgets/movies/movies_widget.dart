import 'package:flutter/material.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_app_constants.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_app_icons.dart';
import 'package:mvvm_architecture_in_flutter/screens/movie_details.dart';
import 'package:mvvm_architecture_in_flutter/services/init_getit.dart';
import 'package:mvvm_architecture_in_flutter/services/navigation_service.dart';
import 'package:mvvm_architecture_in_flutter/widgets/movies/favorite_button.dart';
import 'package:mvvm_architecture_in_flutter/widgets/movies/genres_list_widget.dart';
import '../cached_image.dart';

class MoviesWidget extends StatelessWidget {
  const MoviesWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () {
            getIt<NavigationService>().navigate(
              MovieDetailsScreen(),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicWidth(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: const CachedImageWidget(
                      imgUrl: MyAppConstants.movieImage,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Movie Title",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Icon(
                              MyAppIcons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text("8/10"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GenreListWidget(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              MyAppIcons.watchLaterOutlined,
                              size: 20,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "Release Date",
                              style: TextStyle(color: Colors.grey),
                            ),
                            const Spacer(),
                            FavoriteButtonWidget(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
