import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_architecture_in_flutter/screens/movies_screen.dart';
import 'package:mvvm_architecture_in_flutter/services/init_getit.dart';
import 'package:mvvm_architecture_in_flutter/services/navigation_service.dart';
import 'package:mvvm_architecture_in_flutter/view_models/favorites/favorites_provider.dart';
import 'package:mvvm_architecture_in_flutter/view_models/movies/movies_provider.dart';
import 'package:mvvm_architecture_in_flutter/widgets/my_error_widget.dart';

final initializationOfProvider = FutureProvider.autoDispose<void>((ref) async {
  ref.keepAlive();
  await Future.microtask(() async {
    await ref.read(favoritesProvider.notifier).loadFavorites();
    await ref.read(moviesProvider.notifier).getMovies();
  });
});

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initWatch = ref.watch(initializationOfProvider);
    return Scaffold(
      body: initWatch.when(
        data: (data) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            getIt<NavigationService>().navigateReplace(
              const MoviesScreen(),
            );
          });

          return SizedBox.shrink();
        },
        error: (error, _) {
          return MyErrorWidget(
              errorText: error.toString(),
              retyFunction: () => ref.refresh(initializationOfProvider));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
// using the future builder with the riverpood state management
// import 'dart:developer';

// class SplashScreen extends ConsumerWidget {
//   const SplashScreen({super.key});

//   Future<void> _loadInitialData(WidgetRef ref) async {
//     await Future.microtask(() async {
//       await ref.read(moviesProvider.notifier).getMovies();
//     });
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     //if you do this, you will have an infinite loop with the future builder
//     //this will couse rebuild for future builder and it will keep updating the state
//     // final moviesstateProvider = ref.read(moviesProvider);
//     // log('moviesProvider genres length ${moviesStateProvider.genresList.length}');
//     return Scaffold(
//         body: FutureBuilder(
//       future: _loadInitialData(ref),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator.adaptive());
//         } else if (snapshot.hasError) {
//           if (ref.read(moviesProvider).genresList.isNotEmpty) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               getIt<NavigationService>().navigateReplace(
//                 const MoviesScreen(),
//               );
//             });
//           }
//           return MyErrorWidget(
//               errorText: snapshot.error.toString(),
//               retyFunction: () async {
//                 await _loadInitialData(ref);
//               });
//         } else {
//           log('moviesProvider genres length ${ref.read(moviesProvider).genresList.length}');
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             getIt<NavigationService>().navigateReplace(
//               const MoviesScreen(),
//             );
//           });
//           return const SizedBox.shrink();
//         }
//       },
//     ));
//   }
// }
