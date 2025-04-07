// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ThemeState {
//   final ThemeMode themeMode;

//   ThemeState({this.themeMode = ThemeMode.system});

//   ThemeState copyWith({ThemeMode? themeMode}) {
//     return ThemeState(
//       themeMode: themeMode ?? this.themeMode,
//     );
//   }
// }

// class ThemeCubit extends Cubit<ThemeState> {
//   ThemeCubit() : super(ThemeState());

//   void toggleTheme() {
//     final newMode = state.themeMode == ThemeMode.light
//         ? ThemeMode.dark
//         : ThemeMode.light;
//     emit(state.copyWith(themeMode: newMode));
//   }

//   void setThemeMode(ThemeMode mode) {
//     emit(state.copyWith(themeMode: mode));
//   }
// } 

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('is_dark_mode') ?? false;
    emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggleTheme() async {
    final newTheme = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_dark_mode', newTheme == ThemeMode.dark);
    emit(newTheme);
  }
}