
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constance/shared_pref.dart';
import '../../../../core/utils/constance/strings_manager.dart';
import '../../../../core/utils/constance/values_manager.dart';
import '../../../../core/utils/enums.dart';
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
  int indexError = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailTextFormField(emailController: emailController),
        PasswordTextFormField(passwordController: passwordController),
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
                      var selectedOption =
                          sharedPreferences!.getString("placeType") ??
                              "Islamic antiquities";
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) =>
                                sharedPreferences!.getBool("is_manager") == true
                                    ? DashBoardScreen(
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
                      if (indexError == 1) {
                        Navigator.pop(context);
                        setState(() {
                          indexError = 0;
                        });
                      }
                      print(state.loginMessage);
                      message =
                          Validation.validationMessage(state.loginMessage);
                      SnackBarMessage().showErrorSnackBar(
                          message: message, context: context);
                    }
                  },
                  builder: (context, state) {
                    return TextButton(
                      onPressed: () {
                        Login login = Login(
                            // email: "newUser2@gmail.com",
                            // password: "passwordnewUser2");
                            email: emailController.text,
                            password: passwordController.text);
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(LoginEvent(login: login));

                        if (state.loginstate == RequestState.loading) {
                          print("Login Loding");
                          setState(() {
                            indexError = 1;
                          });
                          print(state.loginstate);
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
                        AppStrings.loginString.toUpperCase(),
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "rye",
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
