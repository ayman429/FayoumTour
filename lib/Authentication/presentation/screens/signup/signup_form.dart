import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constance/shared_pref.dart';
import '../../../../core/utils/constance/strings_manager.dart';
import '../../../../core/utils/constance/values_manager.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/snackbar_message.dart';
import '../../../../home/BottomBar.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
            if (state.registrationstate == RequestState.loaded) {
              // print("---------- SignUp userId -------------");
              // print(state.userDetails!.id);
              //  sharedPreferences!.setString("USERID",state.userDetails!.id);
              var _selectedOption =
                  sharedPreferences!.getString("selectedOption");
              if (_selectedOption != null) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            BottomBar(select: 1, _selectedOption)),
                    (route) => false);
              } else {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => TourismScreen()),
                    (route) => false);
              }
            } else if (state.registrationstate == RequestState.error) {
              String message;
              message = Validation.validationMessage(state.registrationMessage);
              SnackBarMessage()
                  .showErrorSnackBar(message: message, context: context);
            }
          }, builder: (context, state) {
            if (state.registrationstate == RequestState.loading) {
              /// loading
              // return Text("Processing");
            }
            return Container();
          }),
        ),
        UserNameTextFormField(userNameController: userNameController),
        EmailTextFormField(emailController: emailController),
        PasswordTextFormField(passwordController: password1Controller),
        const SizedBox(height: AppPadding.p16),
        PasswordTextFormField(passwordController: password2Controller),
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
                  // print(userNameController.text);
                  // print(emailController.text);
                  // print(password1Controller.text);
                  // print(password2Controller.text);
                  Registration registration = Registration(
                    username: userNameController.text,
                    email: emailController.text,
                    password1: password1Controller.text,
                    password2: password2Controller.text,
                  );
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(RegistrationEvent(registration: registration));
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  AppStrings.signUpString.toUpperCase(),
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
