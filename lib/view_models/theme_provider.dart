import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_architecture_in_flutter/enums/theme_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

// changeNotifierProvider<ThemeProvider>(create:(_)=ThemeProvider);

final themeProvider =
    StateNotifierProvider<ThemeProvider, ThemeEnums>((_) => ThemeProvider());

class ThemeProvider extends StateNotifier<ThemeEnums> {
  final prefsKey = 'isDarkMode';
  ThemeProvider() : super(ThemeEnums.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(prefsKey) ?? false;
    state = isDarkMode ? ThemeEnums.dark : ThemeEnums.light;
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();

    if (state == ThemeEnums.light) {
      state = ThemeEnums.dark;
      await prefs.setBool(prefsKey, true);
    } else {
      state = ThemeEnums.light;
      await prefs.setBool(prefsKey, false);
    }
  }
}
