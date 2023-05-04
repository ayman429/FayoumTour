import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constance/shared_pref.dart';
import '../../constance/strings_manager.dart';

part 'app_theme_event.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  AppThemeBloc() : super(AppThemeInitial()) {
    on<InitialThemeEvent>((event, emit) {
      if (sharedPreferences!.getString(AppStrings.themeString) != null) {
        if (sharedPreferences!.getString(AppStrings.themeString) ==
            AppStrings.lightString) {
          emit(AppChangeTheme(appTheme: AppStrings.lightString));
        } else {
          emit(AppChangeTheme(appTheme: 'dark'));
        }
      }
    });
    on<LightThemeEvent>((event, emit) {
      sharedPreferences!
          .setString(AppStrings.themeString, AppStrings.lightString);
      emit(AppChangeTheme(appTheme: AppStrings.lightString));
    });
    on<DarkThemeEvent>((event, emit) {
      sharedPreferences!
          .setString(AppStrings.themeString, AppStrings.darkString);
      emit(AppChangeTheme(appTheme: AppStrings.darkString));
    });
  }
}
