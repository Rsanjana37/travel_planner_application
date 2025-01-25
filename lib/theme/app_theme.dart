import 'package:flutter/material.dart';

class AppTheme {
  static const MaterialColor primaryCol = Colors.teal;
  static const Color accentColor = Colors.tealAccent;

  static ThemeData theme = ThemeData(
    primarySwatch: primaryCol,
    hintColor: accentColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryCol,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryCol,
      ),
    ),
  );
}
