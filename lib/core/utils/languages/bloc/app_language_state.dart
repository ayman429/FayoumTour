part of 'app_language_bloc.dart';

abstract class AppLanguageState {}

class AppLanguageInitial extends AppLanguageState {}

class AppChangeLanguage extends AppLanguageState {
  final String? languageCode;

  AppChangeLanguage({this.languageCode});
}
