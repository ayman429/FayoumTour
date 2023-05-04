import 'package:flutter/material.dart';

import '../../../core/utils/constance/color_manager.dart';
import '../../../core/utils/constance/strings_manager.dart';
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
        decoration: const InputDecoration(
          hintText: AppStrings.emailHint,
          prefixIcon: Padding(
            padding: EdgeInsets.all(AppPadding.p16),
            child: Icon(Icons.mail),
          ),
        ),
      ),
    );
  }
}
