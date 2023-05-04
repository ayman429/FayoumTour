import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/enums.dart';
import '../../controller/authentication_bloc.dart';
import '../../controller/authentication_event.dart';
import '../../controller/authentication_state.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return getIt<AuthenticationBloc>()..add(GetUserDetailsEvent());
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        // print("object");
        // print(state);
        if (state.userDetailsState == RequestState.loading) {
          print("loading");
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state.userDetailsState == RequestState.loaded) {
          print("st: ${state.userDetailsState}");
          print("email:${state.userDetails!.email}");
          return Scaffold(
            appBar: AppBar(),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("username: ${state.userDetails!.username}"),
                    Text("Email: ${state.userDetails!.email}"),
                  ],
                ),
              ],
            ),
          );
        } else if (state.userDetailsState == RequestState.error) {
          print("error");
          return const Scaffold(
            body: Center(child: Text("Error")),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text("Error")),
          );
        }
      }),
    );
  }
}
