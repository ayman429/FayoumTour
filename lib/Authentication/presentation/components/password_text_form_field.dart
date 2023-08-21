import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/values_manager.dart';
import '../controller/obscure_bloc.dart';

class PasswordTextFormField extends StatelessWidget {
  final passwordController;
  bool isConfirm;
  PasswordTextFormField(
      {Key? key, required this.passwordController, required this.isConfirm})
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
                        ? Icons.visibility_off
                        : Icons.visibility)),
                hintText: isConfirm
                    ? AppLocalizations.of(context)!
                        .translate("Confirm Password")
                    : AppLocalizations.of(context)!.translate("Your password"),
                hintStyle: TextStyle(fontSize: (16/360)*MediaQuery.of(context).size.width,),
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
