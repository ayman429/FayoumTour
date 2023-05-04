import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/constance/values_manager.dart';

class TopImageLoginAndSigup extends StatelessWidget {
  final loginSignupString;
  final imagePath;
  const TopImageLoginAndSigup({
    Key? key,
    this.loginSignupString,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          loginSignupString,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppPadding.p16 * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset(imagePath),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: AppPadding.p16 * 2),
      ],
    );
  }
}
