import 'package:flutter/material.dart';

import '../../../core/utils/app_localizations.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              login
                  ? AppLocalizations.of(context)!.translate("dontHaveAccount")
                  : AppLocalizations.of(context)!
                      .translate("alreadyHaveAccount"),
              // style: TextStyle(color: ColorManager.kPrimaryColor),
              style: const TextStyle(fontFamily: "merriweather")),
          GestureDetector(
            onTap: press as void Function()?,
            child: Text(
              login
                  ? AppLocalizations.of(context)!.translate("Sign Up")
                  : AppLocalizations.of(context)!.translate("Sign In"),
              style: TextStyle(
                  fontFamily: "merriweather",
                  color: Theme.of(context).colorScheme.primary),
              // style: const TextStyle(
              //   // color: ColorManager.kPrimaryColor,
              //   fontWeight: FontWeight.bold,
              // ),
            ),
          )
        ],
      ),
    );
  }
}
