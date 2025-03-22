import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_them_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<LoadThemeEvent>(_loadTheme);
    on<ToggleThemeEvent>(toggleTheme);
  }
  final prefsKey = 'isDarkMode';

  Future<void> _loadTheme(event, emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(prefsKey) ?? false;
    if (isDarkMode) {
      emit(DarkThemeState(themeData: MyThemData.darkTheme));
    } else {
      emit(LightThemeState(themeData: MyThemData.lightTheme));
    }
  }

  Future<void> toggleTheme(event, emit) async {
    final prefs = await SharedPreferences.getInstance();
    final currentState = state;

    if (currentState is LightThemeState) {
      emit(DarkThemeState(themeData: MyThemData.darkTheme));
      await prefs.setBool(prefsKey, true);
    } else {
      emit(LightThemeState(themeData: MyThemData.lightTheme));
      await prefs.setBool(prefsKey, false);
    }
  }
}
