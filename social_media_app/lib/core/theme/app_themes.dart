import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode {
  light,
  dark,
  custom
}

class AppThemes {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.grey,
    primaryColor: Colors.white.withAlpha(240), // Slightly darker than pure white
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 1,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black54),
    ),
    iconTheme: const IconThemeData(color: Colors.black87),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
    primaryColor: const Color(0xFF121212), // Slightly lighter than pure black
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 1,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white,
    ),
  );

  // Custom Theme (can be expanded later)
  static final ThemeData customTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.grey,
    primaryColor: Colors.white.withAlpha(240), // Slightly darker than pure white
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 1,
    ),
    iconTheme: const IconThemeData(color: Colors.black87),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
    ),
  );
}

// Theme Provider
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(AppThemes.lightTheme) {
    _loadThemeFromPrefs();
  }

  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('theme_mode') ?? 0;
    
    switch (themeIndex) {
      case 0:
        state = AppThemes.lightTheme;
        break;
      case 1:
        state = AppThemes.darkTheme;
        break;
      case 2:
        state = AppThemes.customTheme;
        break;
      default:
        state = AppThemes.lightTheme;
    }
  }

  void setTheme(AppThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    
    switch (themeMode) {
      case AppThemeMode.light:
        state = AppThemes.lightTheme;
        await prefs.setInt('theme_mode', 0);
        break;
      case AppThemeMode.dark:
        state = AppThemes.darkTheme;
        await prefs.setInt('theme_mode', 1);
        break;
      case AppThemeMode.custom:
        state = AppThemes.customTheme;
        await prefs.setInt('theme_mode', 2);
        break;
    }
  }
}
