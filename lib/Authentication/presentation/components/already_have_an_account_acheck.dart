import 'package:flutter/material.dart';

import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/shared_pref.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
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
              style: TextStyle(fontFamily: sharedPreferences!.getString("Language") == "AR" ? "ibmP" : "merriweather",
              fontSize: (13/360)*MediaQuery.of(context).size.width,
              )
              ),
          GestureDetector(
            onTap: press as void Function()?,
            child: Text(
              login
                  ? AppLocalizations.of(context)!.translate("Sign Up")
                  : AppLocalizations.of(context)!.translate("Sign In"),
              style: TextStyle(
                  fontFamily: sharedPreferences!.getString("Language") == "AR" ? "ibmP" :"merriweather",
                  fontSize: (13/360)*MediaQuery.of(context).size.width,
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
