import 'dart:convert';
import 'dart:io';

import 'package:fayoumtour/Authentication/domain/entities/user_details.dart';
import 'package:fayoumtour/core/utils/constance/shared_pref.dart';
import 'package:fayoumtour/core/utils/constance/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/local_data_shared_preferences/favourites_shared_preferences.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/enums.dart';
import '../../controller/authentication_bloc.dart';
import '../../controller/authentication_event.dart';
import '../../controller/authentication_state.dart';
import '../login/login_screen.dart';
import 'ProfileMenuWidget.dart';
import 'base_update_profile.dart';
import 'settings.dart';

class profile_screen extends StatefulWidget {
  profile_screen({Key? key}) : super(key: key);

  @override
  State<profile_screen> createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {
  String getImagePath = "";

  UserDetails userDetails =
      UserDetails(id: "", email: "", firstName: "", lastName: "", username: "");
  var username;
  Future<void> updateUIWithUserDetails() async {
    Map<String, dynamic> localUerDetails =
        await json.decode(sharedPreferences!.getString("USER") ?? "");
    username = sharedPreferences!.getString("username") ?? "";
    setState(() {
      username = sharedPreferences!.getString("username") ?? "";

      userDetails = UserDetails(
          id: localUerDetails["id"],
          email: localUerDetails["email"],
          firstName: localUerDetails["firstName"],
          lastName: localUerDetails["lastName"],
          username: localUerDetails["username"]);
    });
  }

  Future<void> updateUIWithImagePath() async {
    Map<String, dynamic> localUerDetails =
        await json.decode(sharedPreferences!.getString("USER") ?? "");

    String imagePath =
        sharedPreferences!.getString("${localUerDetails["id"]}USERIMAGE") ?? "";
    setState(() {
      getImagePath = imagePath;
    });
  }

  @override
  void initState() {
    super.initState();
    updateUIWithImagePath();
    // updateUIWithUserDetails();
  }

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
                      child: FutureBuilder(
                          future: updateUIWithImagePath(),
                          builder: (context, snapshot) =>
                              displayImage(getImagePath)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                future: updateUIWithUserDetails(),
                builder: (context, snapshot) => (userDetails.email != "")
                    ? Column(
                        children: [
                          Text(username, style: GoogleFonts.aBeeZee()),
                          const SizedBox(height: 10),
                          Text(userDetails.email, style: GoogleFonts.aBeeZee()),
                        ],
                      )
                    : Text("welcome", style: GoogleFonts.aBeeZee()),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const BaseUpdateProfile(), //UpdateProfileScreen(),
                        ));
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

Widget displayImage(String imagePath) {
  final File imageFile = File(imagePath);
  if (imagePath.isNotEmpty && imageFile.existsSync()) {
    return Image.file(
      imageFile,
      fit: BoxFit.cover,
    );
  } else {
    return Image.asset(
      AppStrings.profileImage,
      fit: BoxFit.cover,
    );
  }
}
