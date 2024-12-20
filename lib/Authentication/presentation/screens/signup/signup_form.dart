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
import '../../../../home/questions.dart';
import '../../../domain/entities/registration.dart';
import '../../components/email_text_form_field.dart';
import '../../components/password_text_form_field.dart';
import '../../components/user_name_text_form_field.dart';
import '../../components/validation.dart';
import '../../controller/authentication_bloc.dart';
import '../../controller/authentication_event.dart';
import '../../controller/authentication_state.dart';

class SigupForm extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController password1Controller = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();
  SigupForm({Key? key}) : super(key: key);
  // int indexError = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserNameTextFormField(userNameController: userNameController),
        EmailTextFormField(emailController: emailController),
        PasswordTextFormField(
          passwordController: password1Controller,
          isConfirm: false,
        ),
        const SizedBox(height: AppPadding.p16),
        PasswordTextFormField(
          passwordController: password2Controller,
          isConfirm: true,
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
                  if (state.registrationstate == RequestState.loaded) {
                    (sharedPreferences!.getString("Language") == "AR")
                        ? subscribeARTopic()
                        : subscribeENTopic();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const TourismScreen()),
                        (route) => false);
                    // }
                  } else if (state.registrationstate == RequestState.error) {
                    String message;
                    Navigator.pop(context);

                    message =
                        Validation.validationMessage(state.registrationMessage);
                    SnackBarMessage()
                        .showErrorSnackBar(message: message, context: context);
                  }
                }, builder: (context, state) {
                  return TextButton(
                    onPressed: () {
                      Registration registration = Registration(
                        username: userNameController.text,
                        email: emailController.text,
                        password1: password1Controller.text,
                        password2: password2Controller.text,
                      );
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(RegistrationEvent(registration: registration));

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
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.translate("SIGN UP"),
                      style: TextStyle(
                          fontFamily:
                              sharedPreferences!.getString("Language") == "AR"
                                  ? "Mag"
                                  : "rye",
                          fontSize: (17 / 360) *
                              MediaQuery.of(context).size.width, //17,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  );
                }),
              )),
        ),
        const SizedBox(height: AppPadding.p16),
      ],
    );
  }
}
