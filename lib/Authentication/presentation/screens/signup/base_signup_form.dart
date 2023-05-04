import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/services_locator.dart';
import '../../components/already_have_an_account_acheck.dart';
import '../../controller/authentication_bloc.dart';
import '../../controller/obscure_bloc.dart';
import '../login/login_screen.dart';
import 'signup_form.dart';

class BaseSignupForm extends StatelessWidget {
  const BaseSignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ObscureBloc()),
        BlocProvider(create: (context) => getIt<AuthenticationBloc>()),
      ],
      child: Column(
        children: [
          SigupForm(),
          AlreadyHaveAnAccountCheck(
            login: true,
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
