import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import '../../../../core/utils/constance/strings_manager.dart';
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
        title: const Text(
              AppStrings.settings,
              style: TextStyle(
                      fontFamily: AppStrings.fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
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
                  leading: const Text(
                    AppStrings.appTheme,
                    style: TextStyle(
                      fontFamily: "aBeeZee",
                      fontSize: 19),
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
                          textOff: AppStrings.appThemeLight,
                          textOn: AppStrings.appThemeDark,
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
                  leading: const Text(
                    AppStrings.language,
                    style: TextStyle(
                      fontFamily: "aBeeZee",
                      fontSize: 19),
                  ),
                  trailing:
                  LiteRollingSwitch(
                    onChanged: (newValue) {},
                    textSize: 13,
                    onDoubleTap: () {},
                    onSwipe: () {},
                    onTap: () {
                      print("object");
                    },
                    animationDuration: const Duration(microseconds: 100),
                    value: true,
                    textOff: AppStrings.languageArabic,
                    textOn: AppStrings.languageEnglish,
                    //colorOff: Colors.grey,
                    //colorOn: Colors.greenAccent,
                    iconOff: Icons.language,
                    iconOn: Icons.language_outlined,
                    width: 100,
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
