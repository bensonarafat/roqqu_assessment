import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: "Satoshi",
      brightness: Brightness.light,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xffffffff)),
      scaffoldBackgroundColor: const Color(0xfff1f1f1),
      popupMenuTheme: const PopupMenuThemeData(
        color: Color(0xfff1f1f1),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: "Satoshi",
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xff17181B),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xff17181b)),
      popupMenuTheme: const PopupMenuThemeData(
        color: Color(0xff17181b),
      ),
    );
  }
}
