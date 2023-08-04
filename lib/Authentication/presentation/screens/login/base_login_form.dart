import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/already_have_an_account_acheck.dart';
import '../../controller/obscure_bloc.dart';
import '../signup/signup_screen.dart';
import 'login_form.dart';

class BaseLoginForm extends StatelessWidget {
  const BaseLoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ObscureBloc(),
      child: Column(
        children: [
          const LoginForm(),
          AlreadyHaveAnAccountCheck(
            login: true,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
