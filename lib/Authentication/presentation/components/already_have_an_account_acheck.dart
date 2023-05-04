import 'package:flutter/material.dart';

import '../../../core/utils/constance/color_manager.dart';
import '../../../core/utils/constance/strings_manager.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  bool login;
  final Function? press;
  AlreadyHaveAnAccountCheck({
    Key? key,
    required this.login,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? AppStrings.dontHaveAccount : AppStrings.alreadyHaveAccount,
          // style: TextStyle(color: ColorManager.kPrimaryColor),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? AppStrings.loginString : AppStrings.signUpString,
            style: const TextStyle(
              // color: ColorManager.kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
