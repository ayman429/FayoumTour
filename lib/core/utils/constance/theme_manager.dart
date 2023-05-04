import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationThemeLight() {
  return ThemeData(
      textTheme:
          TextTheme(bodyText1: TextStyle(color: AppColorLigth.kPrimaryColor)),
      primaryColor: AppColorLigth.kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: AppColorLigth.kPrimaryColor,
          shape: const StadiumBorder(),
          maximumSize: const Size(double.infinity, 56),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorLigth.kPrimaryLightColor,
        iconColor: AppColorLigth.kPrimaryColor,
        prefixIconColor: AppColorLigth.kPrimaryColor,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16, vertical: AppPadding.p16),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide.none,
        ),
      ));
}

ThemeData getApplicationThemeDark() {
  return ThemeData(
      textTheme:
          TextTheme(bodyText1: TextStyle(color: AppColorDark.darkPrimary)),
      primaryColor: AppColorDark.darkPrimary,
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: AppColorDark.darkPrimary,
          shape: const StadiumBorder(),
          maximumSize: const Size(double.infinity, 56),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorDark.darkPrimary,
        iconColor: AppColorDark.darkPrimary,
        prefixIconColor: AppColorDark.darkPrimary,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16, vertical: AppPadding.p16),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide.none,
        ),
      ));
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