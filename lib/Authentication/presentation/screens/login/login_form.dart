import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constance/strings_manager.dart';
import '../../../../core/utils/constance/values_manager.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/snackbar_message.dart';
import '../../../domain/entities/login.dart';
import '../../components/email_text_form_field.dart';
import '../../components/password_text_form_field.dart';
import '../../components/validation.dart';
import '../../controller/authentication_bloc.dart';
import '../../controller/authentication_event.dart';
import '../../controller/authentication_state.dart';
import '../user details/user_details.dart';

class LoginForm extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
            if (state.loginstate == RequestState.loaded) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => UserDetailsScreen()),
                  //UserDetailsScreen()),
                  (route) => false);
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
          child: ElevatedButton(
            onPressed: () {
              Login login = Login(
                  // email: "newUser2@gmail.com",
                  // password: "passwordnewUser2");
                  email: emailController.text,
                  password: passwordController.text);
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(LoginEvent(login: login));
            },
            child: Text(
              AppStrings.loginString.toUpperCase(),
            ),
          ),
        ),
        const SizedBox(height: AppPadding.p16),
      ],
    );
  }
}
