import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/constance/strings_manager.dart';
import '../../../../../core/utils/constance/values_manager.dart';

class AuthenticationWelcomeImage extends StatelessWidget {
  const AuthenticationWelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          AppStrings.authenticationWelcomeString,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppPadding.p16 * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset(
                AppStrings.authenticationWelcomeImage,
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: AppPadding.p16 * 2),
      ],
    );
  }
}
