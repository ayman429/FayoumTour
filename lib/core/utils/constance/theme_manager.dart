import 'package:flutter/material.dart';


ThemeData getApplicationThemeLight() {
  return ThemeData(
      colorScheme: const ColorScheme.light(
    primary: Colors.green,
    onPrimary: Colors.black,
    secondary: Colors.white,
    onSecondary: Colors.white,
    tertiary: Colors.blue,
    onTertiary: Colors.white,
    primaryContainer: Colors.white,
    tertiaryContainer: Color.fromARGB(255, 230, 230, 230),
    onTertiaryContainer: Colors.white,
  ));
}

ThemeData getApplicationThemeDark() {
  return ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: Colors.green,
      onPrimary: Colors.white,
      secondary: Color(0xff272727),
      onSecondary: Color.fromARGB(255, 21, 21, 21),
      tertiary: Colors.black,
      onTertiary: Colors.grey,
      primaryContainer: Color.fromARGB(255, 56, 56, 56),
      tertiaryContainer: Color.fromARGB(255, 64, 64, 64),
      onTertiaryContainer: Color(0xff272727),
    ),
  );
}
