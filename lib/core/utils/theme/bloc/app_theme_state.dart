part of 'app_theme_bloc.dart';

abstract class AppThemeState {
  final String? appTheme = AppStrings.lightString;
}

class AppThemeInitial extends AppThemeState {}

class AppChangeTheme extends AppThemeState {
  @override
  // ignore: overridden_fields
  final String? appTheme;
  AppChangeTheme({this.appTheme});
}
