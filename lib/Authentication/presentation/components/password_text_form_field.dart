import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/color_manager.dart';
import '../../../core/utils/constance/strings_manager.dart';
import '../../../core/utils/constance/values_manager.dart';
import '../controller/obscure_bloc.dart';

class PasswordTextFormField extends StatelessWidget {
  final passwordController;

  const PasswordTextFormField({Key? key, required this.passwordController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObscureBloc, ObscureState>(
      builder: (context, state) {
        if (state is IsObscureState || state is IsObscureInitial) {
          return TextFormField(
            textInputAction: TextInputAction.next,
            obscureText: state.isObscure,
            // cursorColor: ColorManager.kPrimaryColor,
            controller: passwordController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      BlocProvider.of<ObscureBloc>(context)
                          .add(IsObscureEvent());
                    },
                    icon: Icon(state.isObscure
                        ? Icons.visibility
                        : Icons.visibility_off)),
                hintText:
                    AppLocalizations.of(context)!.translate("Your password"),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(AppPadding.p16),
                  child: Icon(Icons.fingerprint),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p16, vertical: AppPadding.p16),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
