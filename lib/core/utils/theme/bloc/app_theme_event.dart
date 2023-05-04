part of 'app_theme_bloc.dart';

abstract class AppThemeEvent {}

class InitialThemeEvent extends AppThemeEvent {}

class LightThemeEvent extends AppThemeEvent {}

class DarkThemeEvent extends AppThemeEvent {}
