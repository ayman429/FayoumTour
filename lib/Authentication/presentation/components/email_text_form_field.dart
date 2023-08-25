import 'package:flutter/material.dart';

import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/values_manager.dart';

class EmailTextFormField extends StatelessWidget {
  final emailController;

  const EmailTextFormField({Key? key, required this.emailController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        // cursorColor: ColorManager.kPrimaryColor,
        controller: emailController,
        decoration: InputDecoration(
            
            hintText: AppLocalizations.of(context)!.translate("Your email"),
            hintStyle: TextStyle(fontSize: (13/360)*MediaQuery.of(context).size.width,
            fontFamily: "readPro"
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.all(AppPadding.p16),
              child: Icon(Icons.mail),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p16, vertical: AppPadding.p16),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
