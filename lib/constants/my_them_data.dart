import 'package:flutter/material.dart';

class MyThemData {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(
        surface: Color.fromARGB(26, 13, 184, 247),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ));
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(
          // surface: Color.fromARGB(26, 13, 184, 247),
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade800,
        foregroundColor: Colors.white,
        elevation: 1,
      ));
}
