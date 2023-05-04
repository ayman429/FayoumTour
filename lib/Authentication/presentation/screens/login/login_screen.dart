import 'package:flutter/material.dart';
import '../../../../core/utils/constance/strings_manager.dart';
import '../../../../core/utils/responsive.dart';
import '../../components/background.dart';
import '../../components/top_image_login_signup.dart';
import 'base_login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileLoginScreen(),
          desktop: Row(
            children: [
              const Expanded(
                child: TopImageLoginAndSigup(
                    loginSignupString: AppStrings.loginString,
                    imagePath: AppStrings.loginImagePath),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 450,
                      child: BaseLoginForm(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TopImageLoginAndSigup(
            loginSignupString: AppStrings.loginString.toUpperCase(),
            imagePath: AppStrings.loginImagePath),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: BaseLoginForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
