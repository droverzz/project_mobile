import 'package:flutter/material.dart';

// Light Theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Color(0xFFA31621),
    secondary: Color(0xFFEC4751),
    // background: Color(0xFFFCF7F8),
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
  ),
  scaffoldBackgroundColor: Color(0xFFFCF7F8),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFFCF7F8),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFFCF7F8),
    selectedItemColor: Color(0xFFA31621),
    unselectedItemColor: Colors.grey,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    shadowColor: Colors.grey[300],
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
  ),
);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF1F1F39),
    secondary: Color(0xFFEC4751),
    // background: Color(0xFF1F1F39),
    surface: Color(0xFF2A2A48),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
  ),
  scaffoldBackgroundColor: Color(0xFF1F1F39),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF1F1F39),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1F1F39),
    selectedItemColor: Color(0xFFEC4751),
    unselectedItemColor: Colors.grey,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
  ),
  cardTheme: CardTheme(
    color: Color(0xFF2A2A48),
    shadowColor: Colors.black54,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Color(0xFF2A2A48),
  ),
);
