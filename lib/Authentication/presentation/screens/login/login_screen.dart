import 'package:flutter/material.dart';
import '../../../../core/utils/constance/strings_manager.dart';
import '../../../../core/utils/responsive.dart';
import 'base_login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileLoginScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: Hero(
                  tag: AppStrings.loginHeroTag,
                  child: Container(
                    margin:  EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.17, 0, 0),
                    height: 200,
                    width: 200,
                    child: Image.asset(AppStrings.logoImage),
                  ),
                ),
              ),
              const Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
      children: [
        Container(
          margin:  EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.17, 0, 0),
          height: 200,
          width: 200,
          child: Image.asset(AppStrings.logoImage),
        ),
        const Row(
          children: [
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
