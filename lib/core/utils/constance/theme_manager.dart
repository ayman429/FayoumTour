import 'package:flutter/material.dart';


ThemeData getApplicationThemeLight() {
  return ThemeData(
      // textTheme:
      //     TextTheme(bodyText1: TextStyle(color: AppColorLigth.kPrimaryColor)),
      // primaryColor: AppColorLigth.kPrimaryColor,
      // scaffoldBackgroundColor: Colors.white.withOpacity(.95),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     elevation: 0,
      //     primary: AppColorLigth.kPrimaryColor,
      //     shape: const StadiumBorder(),
      //     maximumSize: const Size(double.infinity, 56),
      //     minimumSize: const Size(double.infinity, 56),
      //   ),
      // ),
      // inputDecorationTheme: const InputDecorationTheme(
      //   contentPadding: EdgeInsets.symmetric(
      //       horizontal: AppPadding.p16, vertical: AppPadding.p16),
      // filled: true,
      // fillColor: AppColorLigth.kPrimaryLightColor,
      // iconColor: AppColorLigth.kPrimaryColor,
      // prefixIconColor: AppColorLigth.kPrimaryColor,

      // border: const OutlineInputBorder(
      //   borderRadius: BorderRadius.all(Radius.circular(30)),
      //   borderSide: BorderSide.none,
      // ),
      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
      // ),
      // -------------------------------------------------------------------------
      colorScheme: const ColorScheme.light(
    primary: Colors.green,
    onPrimary: Colors.black,
    secondary: Colors.white,
    onSecondary: Colors.white,
    tertiary: Colors.blue,
    onTertiary: Colors.white,
    primaryContainer: Colors.white,
    tertiaryContainer: Color.fromARGB(255, 240, 240, 240),
    onTertiaryContainer: Color.fromARGB(110, 209, 209, 209),
  ));
}

ThemeData getApplicationThemeDark() {
  return ThemeData(
    // textTheme: TextTheme(bodyText1: TextStyle(color: AppColorDark.darkPrimary)),
    // primaryColor: AppColorDark.darkPrimary,
    // scaffoldBackgroundColor: Colors.white,
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     elevation: 0,
    //     primary: AppColorDark.darkPrimary,
    //     shape: const StadiumBorder(),
    //     maximumSize: const Size(double.infinity, 56),
    //     minimumSize: const Size(double.infinity, 56),
    //   ),
    // ),
    // inputDecorationTheme: InputDecorationTheme(
    //   filled: true,
    //   fillColor: AppColorDark.darkPrimary,
    //   iconColor: AppColorDark.darkPrimary,
    //   prefixIconColor: AppColorDark.darkPrimary,
    //   contentPadding: const EdgeInsets.symmetric(
    //       horizontal: AppPadding.p16, vertical: AppPadding.p16),
    //   border: const OutlineInputBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(30)),
    //     borderSide: BorderSide.none,
    //   ),
    // ),
    // -------------------------------------------------------------------------
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


// ThemeData(
  //   // main colors
  //   // primaryColor: ColorManager.primary,
  //   // primaryColorLight: ColorManager.lightPrimary,
  //   // primaryColorDark: ColorManager.darkPrimary,
  //   // disabledColor: ColorManager.darkGrey,
  //   // splashColor: ColorManager.lightPrimary,

  //   // app bar theme
  //   appBarTheme: AppBarTheme(),

  // );