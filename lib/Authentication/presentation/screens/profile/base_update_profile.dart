import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/services_locator.dart';
import '../../controller/authentication_bloc.dart';
import '../../controller/obscure_bloc.dart';
import 'update_profile_screen.dart';

class BaseUpdateProfile extends StatelessWidget {
  const BaseUpdateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ObscureBloc()),
        BlocProvider(create: (context) => getIt<AuthenticationBloc>()),
      ],
      child: UpdateProfileScreen(),
    );
  }
}
