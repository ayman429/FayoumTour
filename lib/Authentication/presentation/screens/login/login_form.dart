import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/notification/subscribe_topic.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/app_localizations.dart';
import '../../../../core/utils/constance/shared_pref.dart';
import '../../../../core/utils/constance/strings_manager.dart';
import '../../../../core/utils/constance/values_manager.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/languages/bloc/app_language_bloc.dart';
import '../../../../core/utils/snackbar_message.dart';
import '../../../../home/BottomBar.dart';
import '../../../../home/DashBoard2.dart';
import '../../../domain/entities/login.dart';
import '../../components/email_text_form_field.dart';
import '../../components/password_text_form_field.dart';
import '../../components/validation.dart';
import '../../controller/authentication_bloc.dart';
import '../../controller/authentication_event.dart';
import '../../controller/authentication_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  // int indexError = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailTextFormField(emailController: emailController),
        PasswordTextFormField(
          passwordController: passwordController,
          isConfirm: false,
        ),
        const SizedBox(height: AppPadding.p16),
        DropdownButtonFormField<int>(
          borderRadius: BorderRadius.circular(15),
          value: sharedPreferences!.getString("Language") == "AR" ? 1 : 0,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Image.asset(
                sharedPreferences!.getString("Language") == "AR"
                    ? "assets/images/arabic_flag.png"
                    : "assets/images/english_flag.png",
                height: (20 / 772) * MediaQuery.of(context).size.height,//17,
                width: (25 / 360) * MediaQuery.of(context).size.width,//25,
                fit: BoxFit.cover,
                //style: TextStyle(fontSize: (20 / 360) * MediaQuery.of(context).size.width,),
              ),
            ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
          ),
          items: [
            DropdownMenuItem(
              value: 0,
              child: Text(
                  AppLocalizations.of(context)!.translate("English"),
                  style: TextStyle(
                    fontSize: (12.5 / 360) * MediaQuery.of(context).size.width,fontFamily: "readPro"
                  ),
                ),
            ),
            DropdownMenuItem(
              value: 1,
              child: Text(
                  AppLocalizations.of(context)!.translate("Arabic"),
                  style: TextStyle(
                    fontSize: (12.5 / 360) * MediaQuery.of(context).size.width,fontFamily: "readPro"
                  ),
                ),
            ),
          ],
          onChanged: (value) {
            if (value == 0) {
              BlocProvider.of<AppLanguageBloc>(context)
                  .add(EnglishLanguageEvent());
              sharedPreferences!.setString("Language", "EN");
            } else {
              BlocProvider.of<AppLanguageBloc>(context)
                  .add(ArabicLanguageEvent());
              sharedPreferences!.setString("Language", "AR");
            }
          },
        ),
        const SizedBox(height: AppPadding.p16),
        Hero(
          tag: AppStrings.loginHeroTag,
          child: SizedBox(
              height: 55,
              width: 320,
              child: BlocProvider(
                create: (context) => getIt<AuthenticationBloc>(),
                child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state.loginstate == RequestState.loaded) {
                      (sharedPreferences!.getString("Language") == "AR")
                          ? subscribeARTopic()
                          : subscribeENTopic();
                      var selectedOption =
                          sharedPreferences!.getString("placeType") ??
                              "Islamic antiquities";
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) =>
                                sharedPreferences!.getBool("is_manager") == true
                                    ? const DashBoardScreen(
                                        select: 0,
                                      )
                                    // ? DashBoard()
                                    : BottomBar(
                                        select: 2,
                                        selectedOption,
                                      ),
                          ),
                          (route) => false);
                    } else if (state.loginstate == RequestState.error) {
                      String message;
                      // message = loginValidationMessage(state.loginMessage);
                      // if (indexError == 1) {

                      //   setState(() {
                      //     indexError = 0;
                      //   });
                      // }
                      Navigator.pop(context);
                      //print(state.loginMessage);
                      message =
                          Validation.validationMessage(state.loginMessage);
                      SnackBarMessage().showErrorSnackBar(
                          message: message, context: context);
                      // showDialog(
                      //   barrierDismissible: false,
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return AlertDialog(
                      //       title: Text(
                      //         sharedPreferences!.getString("Language") == "AR"
                      //             ? "رسالة خطأ"
                      //             : "Message Error",
                      //         style: sharedPreferences!.getString("Language") ==
                      //                 "AR"
                      //             ? const TextStyle(fontFamily: "messiri")
                      //             : const TextStyle(fontFamily: "merriweather"),
                      //       ),
                      //       content: Text(
                      //         message,
                      //         style: sharedPreferences!.getString("Language") ==
                      //                 "AR"
                      //             ? const TextStyle(fontFamily: "messiri")
                      //             : const TextStyle(fontFamily: "merriweather"),
                      //       ),
                      //       actions: <Widget>[
                      //         Center(
                      //           child: ElevatedButton(
                      //               onPressed: () {
                      //                 Navigator.of(context).pop();
                      //               },
                      //               style: ElevatedButton.styleFrom(
                      //                 primary: Colors.green,
                      //                 shape: RoundedRectangleBorder(
                      //                     borderRadius:
                      //                         BorderRadius.circular(15)),
                      //               ),
                      //               child: Text(
                      //                 AppLocalizations.of(context)!
                      //                     .translate("Okay"),
                      //                 style: TextStyle(
                      //                     fontFamily: sharedPreferences!
                      //                                 .getString("Language") ==
                      //                             "AR"
                      //                         ? "Mag"
                      //                         : "rye",
                      //                     color: Theme.of(context)
                      //                         .colorScheme
                      //                         .onSecondary),
                      //               )),
                      //         ),
                      //       ],
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(15)),
                      //     );
                      //   },
                      // );

                    }
                  },
                  builder: (context, state) {
                    return TextButton(
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (ctx) => const FractionallySizedBox(
                            widthFactor:
                                0.5, // Set the desired width factor (0.0 to 1.0)
                            child: AlertDialog(
                              content: SizedBox(
                                width: double.infinity,
                                height: 30,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        );

                        Login login = Login(
                            // email: "newUser2@gmail.com",
                            // password: "passwordnewUser2");
                            email: emailController.text,
                            password: passwordController.text);
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(LoginEvent(login: login));

                        // if (state.loginstate == RequestState.loading) {
                        //   //print("Login Loding");
                        //   setState(() {
                        //     indexError = 1;
                        //   });
                        //   //print(state.loginstate);

                        // }
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.translate("SIGN IN"),
                        style: TextStyle(
                            fontSize: (17 / 360) *
                                MediaQuery.of(context).size.width, //17,
                            fontFamily:
                                sharedPreferences!.getString("Language") == "AR"
                                    ? "Mag"
                                    : "rye",
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    );
                  },
                ),
              )),
        ),
        const SizedBox(height: AppPadding.p16),
      ],
    );
  }
}
