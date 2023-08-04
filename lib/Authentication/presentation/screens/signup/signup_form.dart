import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  SigupForm({Key? key}) : super(key: key);
  int indexError = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserNameTextFormField(userNameController: userNameController),
        EmailTextFormField(emailController: emailController),
        PasswordTextFormField(passwordController: password1Controller,isConfirm: false,),
        const SizedBox(height: AppPadding.p16),
        PasswordTextFormField(passwordController: password2Controller,isConfirm: true,),
        const SizedBox(height: AppPadding.p16),
        DropdownButtonFormField<int>(
                      
                      borderRadius: BorderRadius.circular(15),
                      value: sharedPreferences!.getString("Language") == "AR" ? 1 : 0,
                      decoration: InputDecoration(
                        
                        prefixIcon:  Padding(
                        padding: const EdgeInsets.all(AppPadding.p16),
                        child: Text(sharedPreferences!.getString("Language") == "AR" ? "🇸🇦" :"🇬🇧",style: const TextStyle(fontSize: 20),),
                      ),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                                contentPadding: sharedPreferences!.getString("Language") == "AR"
                                ? const EdgeInsets.symmetric(vertical: 18,horizontal: 6)
                                : const EdgeInsets.symmetric(vertical: 16,horizontal: 6),
                        
                      ),
                      items: [
                        DropdownMenuItem(
                                value: 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 1),
                                  child: Text(AppLocalizations.of(context)!.translate("English")),
                                ),
                                ),
                              DropdownMenuItem(
                                value: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 1),
                                  child: Text(AppLocalizations.of(context)!.translate("Arabic")),
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
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const TourismScreen()),
                        (route) => false);
                    // }
                  } else if (state.registrationstate == RequestState.error) {
                    String message;
                    if (indexError == 1) {
                      Navigator.pop(context);
                    }

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

                      if (state.registrationstate == RequestState.loading) {
                        //print("signup Loding");
                        indexError = 1;
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
                      }
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.translate("SIGN UP"),
                      style: TextStyle(
                          fontFamily: sharedPreferences!.getString("Language") == "AR" ? "Mag" : "rye",
                          fontSize: 16,
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
