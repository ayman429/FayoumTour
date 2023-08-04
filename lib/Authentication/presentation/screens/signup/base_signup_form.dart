import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/already_have_an_account_acheck.dart';
import '../../controller/obscure_bloc.dart';
import '../login/login_screen.dart';
import 'signup_form.dart';

class BaseSignupForm extends StatelessWidget {
  const BaseSignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ObscureBloc(),
      child: Column(
        children: [
          SigupForm(),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
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
