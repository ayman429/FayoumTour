import 'package:fayoumtour/core/utils/constance/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/enums.dart';
import '../../controller/authentication_bloc.dart';
import '../../controller/authentication_event.dart';
import '../../controller/authentication_state.dart';
import '../login/login_screen.dart';
import 'ProfileMenuWidget.dart';
import 'settings.dart';

class profile_screen extends StatelessWidget {
  profile_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: BlocProvider(
          create: (context) {
            return getIt<AuthenticationBloc>()..add(GetUserDetailsEvent());
          },
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        AppStrings.profileImage,
                        fit: BoxFit.cover,
                      ),
                      // Image.network(
                      //         snapshot.data?.docs[0]["image"],
                      //         fit: BoxFit.cover,
                      //         errorBuilder: (context, error, stackTrace) {
                      //           return Image.asset(
                      //             AppStrings.error1Gif,
                      //             fit: BoxFit.cover,
                      //           );
                      //         },
                      //         loadingBuilder:
                      //             (context, child, loadingProgress) {
                      //           if (loadingProgress != null) {
                      //             return Image.asset(
                      //               AppStrings.loading1Gif,
                      //               fit: BoxFit.cover,
                      //             );
                      //           }
                      //           return child;
                      //         },
                      //       )
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                switch (state.userDetailsState) {
                  case RequestState.loading:
                    return const Text("welcome");
                  case RequestState.loaded:
                    return Column(
                      children: [
                        Text(state.userDetails!.username,
                            style: GoogleFonts.aBeeZee()),
                        const SizedBox(height: 10),
                        Text(state.userDetails!.email,
                            style: GoogleFonts.aBeeZee()),
                      ],
                    );

                  case RequestState.error:
                    print(state.userDetailsMessage.toString());
                    return const Text("data not foud...!");
                }
              }),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const UpdateProfileScreen(),
                    //     ));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.primary,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: Text(("Edit profile"),
                      style: GoogleFonts.rye(
                          color: Theme.of(context).colorScheme.secondary)),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Settings",
                  icon: Icons.settings,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SSSettings()));
                  }),
              ProfileMenuWidget(
                  title: "Billing Details", icon: Icons.wallet, onPress: () {}),
              ProfileMenuWidget(
                  title: "User Management",
                  icon: Icons.verified_user_outlined,
                  onPress: () {}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Information", icon: Icons.info, onPress: () {}),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return ProfileMenuWidget(
                      title: "Logout",
                      icon: Icons.logout_outlined,
                      textColor: Colors.red,
                      endIcon: false,
                      onPress: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(LogoutEvent());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
