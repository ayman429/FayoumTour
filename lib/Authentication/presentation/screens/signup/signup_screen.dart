import 'package:flutter/material.dart';

import '../../../../core/utils/constance/strings_manager.dart';
import '../../../../core/utils/constance/values_manager.dart';
import '../../../../core/utils/responsive.dart';
import '../../components/background.dart';
import '../../components/top_image_login_signup.dart';
import 'base_signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileSignupScreen(),
          desktop: Row(
            children: [
              const Expanded(
                child: TopImageLoginAndSigup(
                    loginSignupString: AppStrings.signUpString,
                    imagePath: AppStrings.signUpImagePath),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 450,
                      child: BaseSignupForm(),
                    ),
                    SizedBox(height: AppPadding.p16 / 2),
                    // SocalSignUp()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TopImageLoginAndSigup(
            loginSignupString: AppStrings.signUpString.toUpperCase(),
            imagePath: AppStrings.signUpImagePath),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: BaseSignupForm(),
            ),
            Spacer(),
          ],
        ),
        // const SocalSignUp()
      ],
    );
  }
}
