import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/local_data_shared_preferences/favourites_shared_preferences.dart';
import '../../../../core/utils/constance/shared_pref.dart';
import '../../../../core/utils/constance/strings_manager.dart';
import '../../../../core/utils/constance/values_manager.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/snackbar_message.dart';
import '../../../../home/BottomBar.dart';
import '../../../../home/questions.dart';
import '../../../domain/entities/login.dart';
import '../../../domain/entities/user_details.dart';
import '../../components/email_text_form_field.dart';
import '../../components/password_text_form_field.dart';
import '../../components/validation.dart';
import '../../controller/authentication_bloc.dart';
import '../../controller/authentication_event.dart';
import '../../controller/authentication_state.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
            if (state.loginstate == RequestState.loaded) {
              // var userId = sharedPreferences!.getString("USERID");
              // var _selectedOption =
              //     sharedPreferences!.getString("$userId selectedOption");
              // if (_selectedOption != null) {
              var selectedOption = sharedPreferences!.getString("placeType") ??
                  "Islamic antiquities";
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          BottomBar(select: 1, selectedOption)),
                  (route) => false);

              // } else {
              //   Navigator.of(context).pushAndRemoveUntil(
              //       MaterialPageRoute(builder: (context) => TourismScreen()),
              //       (route) => false);
              // }
            } else if (state.loginstate == RequestState.error) {
              String message;
              // message = loginValidationMessage(state.loginMessage);
              message = Validation.validationMessage(state.loginMessage);
              SnackBarMessage()
                  .showErrorSnackBar(message: message, context: context);
            }
          }, builder: (context, state) {
            if (state.loginstate == RequestState.loading) {
              /// loading
              // return Text("Processing");
            }
            return Container();
          }),
        ),
        EmailTextFormField(emailController: emailController),
        PasswordTextFormField(passwordController: passwordController),
        const SizedBox(height: AppPadding.p16),
        Hero(
          tag: AppStrings.loginHeroTag,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              height: 55,
              width: 320,
              child: TextButton(
                onPressed: () {
                  Login login = Login(
                      // email: "newUser2@gmail.com",
                      // password: "passwordnewUser2");
                      email: emailController.text,
                      password: passwordController.text);
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(LoginEvent(login: login));
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  AppStrings.loginString.toUpperCase(),
                  style: GoogleFonts.rye(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppPadding.p16),
      ],
    );
  }
}
