import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'Authentication/presentation/screens/Login/login_screen.dart';
import 'core/local_data_shared_preferences/access_token_shared_preferences.dart';
import 'core/notification/add notification.dart';
import 'core/notification/notification.dart';
import 'core/notification/subscribe_topic.dart';
import 'core/utils/app_localizations.dart';
import 'core/services/services_locator.dart';
import 'core/utils/constance/shared_pref.dart';
import 'core/utils/constance/strings_manager.dart';
import 'core/utils/constance/theme_manager.dart';
import 'core/utils/languages/bloc/app_language_bloc.dart';
import 'core/utils/theme/bloc/app_theme_bloc.dart';
import 'home/BottomBar.dart';
import 'home/DashBoard2.dart';
import 'home/questions.dart';
import 'hotels/presentation/screens/hotel_reservation_details_for_manager.dart';
import 'hotels/presentation/screens/hotel_reservation_details_for_user.dart';
import 'post/presentation/controller/bloc/post_bloc.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'post/presentation/screens/comment_screen.dart';
import 'post/presentation/screens/get_comment.dart';

var token = "";
var _selectedOption = "";
Future<void> firebaseMessageBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print(message.messageId);
  }
  print(message.messageId);
}

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //----------------------
  await Firebase.initializeApp();
  FirebaseNotification().notification();
  FirebaseNotification().initLocalNotifications();

  FirebaseMessaging.onBackgroundMessage(firebaseMessageBackgroundHandler);

//----------------------
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  ServicesLocator().init();

  sharedPreferences = await SharedPreferences.getInstance();
  token != "0"
      ? (sharedPreferences!.getString("Language") == "AR")
          ? subscribeARTopic()
          : subscribeENTopic()
      : null;

  // token = await getIt<AccessToken>().getToken();
  // --------------
  token = "37bb23be1fa2003096eb8498920cb0a8be81f2f8";
  AccessToken accessToken = AccessToken();
  accessToken.saveToken(token);
  // --------------
  _selectedOption =
      sharedPreferences!.getString("placeType") ?? "Islamic antiquities";
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
          BlocProvider(
            create: (context) => getIt<PostBloc>()..add(GetPostEvent()),
          ),
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
              navigatorKey: navigatorKey,
              onGenerateRoute: (RouteSettings settings) {
                print("object ${settings.name}");
                switch (settings.name) {
                  case '/reservation':
                    return MaterialPageRoute(
                      builder: (_) => BottomBar(
                          select: 3,
                          _selectedOption != ""
                              ? _selectedOption
                              : "Islamic antiquities"),
                    );
                  case '/post':
                    return MaterialPageRoute(
                      builder: (_) => BottomBar(
                          select: 3,
                          _selectedOption != ""
                              ? _selectedOption
                              : "Islamic antiquities"),
                    );
                  case '/comment':
                    final argument = settings.arguments as Map<String, dynamic>;
                    return MaterialPageRoute(
                      builder: (_) => CommentScreen(
                          postId: int.parse(argument["id"]),
                          createdBy_id: int.parse(argument["createdBy_id"])),
                    );
                  case '/like':
                    return MaterialPageRoute(
                      builder: (_) => BottomBar(
                          select: 3,
                          _selectedOption != ""
                              ? _selectedOption
                              : "Islamic antiquities"),
                    );
                  case '/UserReservation':
                    return MaterialPageRoute(
                      builder: (_) => const HotelsReservationDetailsForUser(),
                    );

                  default:
                    (token == "0")
                        ? const LoginScreen()
                        : sharedPreferences!.getBool("is_manager") == true
                            ? const DashBoardScreen(
                                select: 0,
                              )
                            // ? DashBoard()
                            : _selectedOption == ""
                                ? const TourismScreen()
                                : BottomBar(
                                    select: 2,
                                    _selectedOption != ""
                                        ? _selectedOption
                                        : "Islamic antiquities");
                }
              },
              home: AnimatedSplashScreen(
                backgroundColor: themeState.appTheme == AppStrings.lightString
                    ? Colors.white
                    : const Color.fromARGB(255, 21, 21, 21),
                animationDuration: const Duration(milliseconds: 500),
                splashTransition: SplashTransition.scaleTransition,
                splashIconSize: 250,
                splash: Center(
                  child: Image.asset(
                    AppStrings.logoImage,
                    height: 290,
                    width: 290,
                  ),
                ),
                nextScreen: (token == "0")
                    ? const LoginScreen()
                    : sharedPreferences!.getBool("is_manager") == true
                        ? const DashBoardScreen(
                            select: 0,
                          )
                        // ? DashBoard()
                        : _selectedOption == ""
                            ? const TourismScreen()
                            : BottomBar(
                                select: 2,
                                _selectedOption != ""
                                    ? _selectedOption
                                    : "Islamic antiquities"),
              ));
          // : HotelsReservationDetailsForManager());
        }));
  }
}
