import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_localizations.dart';
import 'core/utils/languages/bloc/app_language_bloc.dart';
import 'core/utils/theme/bloc/app_theme_bloc.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.translate("home_page")),
              // Text(message),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AppLanguageBloc>(context)
                        .add(ArabicLanguageEvent());
                  },
                  child: Text("اللغة العربية")),
              SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AppLanguageBloc>(context)
                        .add(EnglishLanguageEvent());
                  },
                  child: Text("English")),
              SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AppThemeBloc>(context)
                        .add(LightThemeEvent());
                  },
                  child: Text("Light Theme")),
              SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AppThemeBloc>(context)
                        .add(DarkThemeEvent());
                  },
                  child: Text("Dark Teme")),
            ],
          )),
    );
  }
}
