import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/app_localizations.dart';
import '../../../../core/utils/constance/strings_manager.dart';
import '../../../../core/utils/constance/values_manager.dart';
import '../../../../core/utils/enums.dart';
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
        PasswordTextFormField(passwordController: password1Controller),
        const SizedBox(height: AppPadding.p16),
        PasswordTextFormField(passwordController: password2Controller),
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
                        print("signup Loding");
                        indexError = 1;
                        showDialog(
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
                          fontFamily: "rye",
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
