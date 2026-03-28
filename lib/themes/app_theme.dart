import 'package:flutter/material.dart';

enum AppTheme { lightMode, darkMode }

class AppThemes {
  // dark mode
  static final appThemeData = {
    AppTheme.darkMode: ThemeData(
      colorScheme: ColorScheme.dark(
        primary: Colors.grey.shade500,
        secondary: Colors.grey.shade700,
        tertiary: Colors.grey.shade900,
        inversePrimary: Colors.grey.shade300,
      ),
      scaffoldBackgroundColor: Colors.grey.shade800,
    ),

    // light mode
    AppTheme.lightMode: ThemeData(
      colorScheme: ColorScheme.light(
        primary: Colors.grey.shade500,
        secondary: Colors.grey.shade200,
        tertiary: Colors.white,
        inversePrimary: Colors.grey.shade900,
      ),
      scaffoldBackgroundColor: Colors.grey.shade300,
    ),
  };
}
