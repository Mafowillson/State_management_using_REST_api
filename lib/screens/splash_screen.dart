import 'package:flutter/material.dart';
import 'package:mvvm_architecture_in_flutter/screens/movies_screen.dart';
import 'package:mvvm_architecture_in_flutter/services/init_getit.dart';
import 'package:mvvm_architecture_in_flutter/services/navigation_service.dart';
import 'package:mvvm_architecture_in_flutter/view_medels/favorites_provider.dart';
import 'package:mvvm_architecture_in_flutter/view_medels/movies_provider.dart';
import 'package:mvvm_architecture_in_flutter/widgets/my_error_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _loadInitialData(BuildContext context) async {
    await Provider.of<MoviesProvider>(context, listen: false).getMovies();
    if (!context.mounted) return;
    await Provider.of<FavoritesProvider>(context, listen: false)
        .loadFavorites();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<MoviesProvider>(context, listen: false).getMovies();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return Scaffold(
        body: FutureBuilder(
      future: _loadInitialData(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (snapshot.hasError) {
          if (moviesProvider.genresList.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              getIt<NavigationService>().navigateReplace(
                const MoviesScreen(),
              );
            });
          }
          return Provider.of<MoviesProvider>(context).isLoading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyErrorWidget(
                          errorText: snapshot.error.toString(),
                          retyFunction: () async {
                            await _loadInitialData(context);
                          }),
                    ],
                  ),
                );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            getIt<NavigationService>().navigateReplace(
              const MoviesScreen(),
            );
          });
          return const SizedBox.shrink();
        }
      },
    ));
  }
}
