import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import '../../../../core/utils/app_localizations.dart';
import '../../../../core/utils/constance/shared_pref.dart';
import '../../../../core/utils/constance/strings_manager.dart';
import '../../../../core/utils/languages/bloc/app_language_bloc.dart';
import '../../../../core/utils/theme/bloc/app_theme_bloc.dart';

class SSSettings extends StatelessWidget {
  const SSSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          // AppStrings.settings,
          AppLocalizations.of(context)!.translate("Settings"),
          style: sharedPreferences!.getString("Language") == "AR"
            ? const TextStyle(
                fontFamily: "galaxy",
                fontWeight: FontWeight.bold,
                fontSize: 28)
            : const TextStyle(
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 25)
        ),
        backgroundColor: Colors.transparent,
      ),
      body: FadeIn(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              child: Card(
                color: Theme.of(context).colorScheme.secondary,
                child: ListTile(
                  leading: Text(
                    AppLocalizations.of(context)!.translate("App Theme"),
                    style: sharedPreferences!.getString("Language") == "AR"
                    ? const TextStyle(fontFamily: "messiri", fontSize: 19)
                    : const TextStyle(fontFamily: "aBeeZee", fontSize: 19),
                  ),
                  trailing: BlocBuilder<AppThemeBloc, AppThemeState>(
                      builder: (context, state) {
                    if (state is AppChangeTheme || state is AppThemeInitial) {
                      return LiteRollingSwitch(
                          textSize: 13,
                          
                          animationDuration: const Duration(microseconds: 100),
                          value: (state.appTheme == AppStrings.darkString)
                              ? true
                              : false,
                          // value: _themeManager.themeMode == ThemeMode.dark,
                          textOff:
                              AppLocalizations.of(context)!.translate("Light"),
                          textOn:
                              AppLocalizations.of(context)!.translate("Dark"),
                          //colorOff: Colors.grey,
                          //colorOn: Colors.greenAccent,
                          iconOff: Icons.light_mode,
                          iconOn: Icons.dark_mode,
                          width: 100,
                          onDoubleTap: () {},
                          onSwipe: () {},
                          onTap: () {},
                          onChanged: (newValue) {
                            if (newValue) {
                              BlocProvider.of<AppThemeBloc>(context)
                                  .add(DarkThemeEvent());
                            } else {
                              BlocProvider.of<AppThemeBloc>(context)
                                  .add(LightThemeEvent());
                            }
                          });
                    } else {
                      return Container();
                    }
                  }),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              child: Card(
                color: Theme.of(context).colorScheme.secondary,
                child: ListTile(
                  leading: Text(
                    // AppStrings.language,
                    AppLocalizations.of(context)!.translate("Language"),
                    style: sharedPreferences!.getString("Language") == "AR"
                    ? const TextStyle(fontFamily: "messiri", fontSize: 19)
                    : const TextStyle(fontFamily: "aBeeZee", fontSize: 19),
                  ),
                  trailing: BlocBuilder<AppLanguageBloc, AppLanguageState>(
                    builder: (context, state) {
                      return LiteRollingSwitch(
                        onChanged: (newValue) {
                          // print(AppLocalizations.of(context)!
                          //     .translate("Settings"));
                          if (newValue) {
                            BlocProvider.of<AppLanguageBloc>(context)
                                .add(EnglishLanguageEvent());
                            sharedPreferences!.setString("Language", "EN");
                          } else {
                            BlocProvider.of<AppLanguageBloc>(context)
                                .add(ArabicLanguageEvent());
                            sharedPreferences!.setString("Language", "AR");
                          }
                        },
                        textSize: 13,
                        onDoubleTap: () {},
                        onSwipe: () {},
                        onTap: () {
                          //print("object");
                        },
                        animationDuration: const Duration(microseconds: 100),
                        value: (state.languageCode == AppStrings.enCode)
                            ? true
                            : false,
                        textOff:
                            AppLocalizations.of(context)!.translate("Arabic"),
                        textOn:
                            AppLocalizations.of(context)!.translate("English"),
                        //colorOff: Colors.grey,
                        //colorOn: Colors.greenAccent,
                        iconOff: Icons.language,
                        iconOn: Icons.language_outlined,
                        width: 100,
                      );
                    },
                  ),
                  // Switch(
                  //   onChanged: (value) {

                  //   },
                  //   value: true,
                  //     activeColor: Colors.amber,
                  //     activeTrackColor: Colors.cyan,
                  //     inactiveThumbColor: Colors.blueGrey.shade600,
                  //     inactiveTrackColor: Colors.grey.shade400,

                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
