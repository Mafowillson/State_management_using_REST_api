import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_them_data.dart';
import 'package:mvvm_architecture_in_flutter/screens/splash_screen.dart';
import 'package:mvvm_architecture_in_flutter/services/init_getit.dart';
import 'package:mvvm_architecture_in_flutter/services/navigation_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_architecture_in_flutter/view_models/favorites/favorites_bloc.dart';
import 'package:mvvm_architecture_in_flutter/view_models/movies/movies_bloc.dart';
import 'package:mvvm_architecture_in_flutter/view_models/theme/theme_bloc.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    //DeviceOrientation.landscapeleft,
    //DeviceOrientation.landscapeRight,
  ]).then((_) async {
    await dotenv.load(fileName: 'assets/.env');
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (_) => getIt<ThemeBloc>()..add(LoadThemeEvent()),
        ),
        BlocProvider<MoviesBloc>(
          create: (_) => getIt<MoviesBloc>(),
        ),
        BlocProvider<FavoritesBloc>(
          create: (_) => getIt<FavoritesBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: getIt<NavigationService>().navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Movies App',
            theme: state is LightThemeState
                ? MyThemData.lightTheme
                : MyThemData.darkTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
