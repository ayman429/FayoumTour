import 'package:flutter/material.dart';

import '../../../../core/utils/constance/strings_manager.dart';
import '../../../../core/utils/constance/values_manager.dart';
import '../../../../core/utils/responsive.dart';
import 'base_signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileSignupScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: Hero(
                  tag: AppStrings.loginHeroTag,
                  child: Container(
                    margin:  EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.08, 0, 15),
                    height: 200,
                    width: 200,
                    child: Image.asset(AppStrings.logoImage),
                  ),
                ),
              ),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
      children: [
        Container(
          margin:  EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.08, 0, 15),
          height: 200,
          width: 200,
          child: Image.asset(AppStrings.logoImage),
        ),
        const Row(
          children: [
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
