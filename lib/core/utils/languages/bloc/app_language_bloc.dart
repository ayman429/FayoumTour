import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constance/shared_pref.dart';
import '../../constance/strings_manager.dart';

part 'app_language_event.dart';
part 'app_language_state.dart';

class AppLanguageBloc extends Bloc<AppLanguageEvent, AppLanguageState> {
  AppLanguageBloc() : super(AppLanguageInitial()) {
    on<InitialLanguageEvent>((event, emit) {
      if (sharedPreferences!.getString('lang') != null) {
        if (sharedPreferences!.getString('lang') == 'ar') {
          emit(AppChangeLanguage(languageCode: 'ar'));
        } else {
          emit(AppChangeLanguage(languageCode: 'en'));
        }
      }
    });
    on<ArabicLanguageEvent>((event, emit) {
      sharedPreferences!.setString('lang', 'ar');
      emit(AppChangeLanguage(languageCode: 'ar'));
    });
    on<EnglishLanguageEvent>((event, emit) {
      sharedPreferences!.setString('lang', 'en');
      emit(AppChangeLanguage(languageCode: 'en'));
    });
  }
}
