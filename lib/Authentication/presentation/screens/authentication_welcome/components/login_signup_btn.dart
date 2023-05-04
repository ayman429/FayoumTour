import 'package:flutter/material.dart';

import '../../../../../core/utils/constance/color_manager.dart';
import '../../../../../core/utils/constance/strings_manager.dart';
import '../../Login/login_screen.dart';
import '../../Signup/signup_screen.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: AppStrings.loginHeroTag,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
            child: Text(
              AppStrings.loginString.toUpperCase(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SignUpScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              // primary: ColorManager.kPrimaryLightColor,
              elevation: 0),
          child: Text(
            AppStrings.signUpString.toUpperCase(),
            // style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
