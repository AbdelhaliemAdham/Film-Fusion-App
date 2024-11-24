import 'package:flutter/material.dart';

class Themes {
  static TextTheme getTextTheme() => const TextTheme(
        titleSmall: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          fontSize: 11,
          color: Colors.white,
        ),
      );
}
