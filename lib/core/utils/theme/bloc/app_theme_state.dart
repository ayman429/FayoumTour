part of 'app_theme_bloc.dart';

abstract class AppThemeState {}

class AppThemeInitial extends AppThemeState {}

class AppChangeTheme extends AppThemeState {
  final String? appTheme;
  AppChangeTheme({this.appTheme});
}
