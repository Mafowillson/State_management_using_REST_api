import 'package:flutter/material.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_them_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeMode = MyThemData.lightTheme;

  ThemeData get themeData => _themeMode;

  final String themeKey = 'isDarkMode';

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final isDarkMode = prefs.getBool(themeKey) ?? false;

    _themeMode = isDarkMode ? MyThemData.darkTheme : MyThemData.lightTheme;

    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = _themeMode == MyThemData.darkTheme
        ? MyThemData.lightTheme
        : MyThemData.darkTheme;
    await prefs.setBool(themeKey, _themeMode == MyThemData.darkTheme);
    notifyListeners();
  }
}
