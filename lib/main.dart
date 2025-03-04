import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_them_data.dart';
import 'package:mvvm_architecture_in_flutter/enums/theme_enums.dart';
import 'package:mvvm_architecture_in_flutter/screens/splash_screen.dart';
import 'package:mvvm_architecture_in_flutter/services/init_getit.dart';
import 'package:mvvm_architecture_in_flutter/services/navigation_service.dart';
import 'package:mvvm_architecture_in_flutter/view_models/theme_provider.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    //DeviceOrientation.landscapeleft,
    //DeviceOrientation.landscapeRight,
  ]).then((_) async {
    await dotenv.load(fileName: 'assets/.env');
    runApp(ProviderScope(child: MyApp()));
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    return MaterialApp(
      navigatorKey: getIt<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      theme: themeState == ThemeEnums.dark
          ? MyThemData.darkTheme
          : MyThemData.lightTheme,
      home: const SplashScreen(),
    );
  }
}
