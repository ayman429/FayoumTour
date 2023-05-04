import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Authentication/presentation/screens/authentication_welcome/authentication_welcome_screen.dart';
import 'core/utils/app_localizations.dart';
import 'core/services/services_locator.dart';
import 'core/utils/constance/shared_pref.dart';
import 'core/utils/constance/strings_manager.dart';
import 'core/utils/constance/theme_manager.dart';
import 'core/utils/languages/bloc/app_language_bloc.dart';
import 'core/utils/theme/bloc/app_theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();

  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AppThemeBloc()..add(InitialThemeEvent())),
          BlocProvider(
              create: (context) =>
                  AppLanguageBloc()..add(InitialLanguageEvent())),
        ],
        child: Builder(builder: (context) {
          var themeState = context.select((AppThemeBloc bloc) => bloc.state);
          var langState = context.select((AppLanguageBloc bloc) => bloc.state);

          return MaterialApp(
              theme: themeState is AppChangeTheme
                  ? themeState.appTheme == AppStrings.lightString
                      ? getApplicationThemeLight()
                      : getApplicationThemeDark()
                  : getApplicationThemeLight(),
              locale: langState is AppChangeLanguage
                  ? langState.languageCode == 'en'
                      ? const Locale(AppStrings.enCode)
                      : const Locale(AppStrings.arCode)
                  : const Locale(AppStrings.enCode),
              debugShowCheckedModeBanner: false,
              supportedLocales: const [
                Locale(AppStrings.enCode),
                Locale(AppStrings.arCode)
              ],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate, // android
                GlobalWidgetsLocalizations
                    .delegate, // direction (right and left)
                GlobalCupertinoLocalizations.delegate, // ios
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                for (var local in supportedLocales) {
                  if (deviceLocale != null) {
                    if (deviceLocale.languageCode == local.languageCode) {
                      return deviceLocale;
                    }
                  }
                }
                return deviceLocale;
              },
              home: const AuthenticationWelcomeScreen());
        }));
  }
}
