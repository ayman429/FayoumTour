import 'package:flutter/material.dart';

import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/values_manager.dart';

class UserNameTextFormField extends StatelessWidget {
  final userNameController;

  const UserNameTextFormField({Key? key, required this.userNameController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      // cursorColor: ColorManager.kPrimaryColor,
      controller: userNameController,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.translate("Your name"),
        hintStyle: TextStyle(fontSize: (13/360)*MediaQuery.of(context).size.width,fontFamily: "readPro"),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: Icon(Icons.person),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16, vertical: AppPadding.p16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
