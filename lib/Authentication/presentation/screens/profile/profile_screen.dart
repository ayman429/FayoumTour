import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fayoumtour/Authentication/domain/entities/user_details.dart';
import 'package:fayoumtour/core/utils/constance/shared_pref.dart';
import 'package:fayoumtour/core/utils/constance/strings_manager.dart';

import '../../../../core/local_data_shared_preferences/access_token_shared_preferences.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/app_localizations.dart';
import '../../../../home/ScanQR.dart';
import '../../../../home/info.dart';
import '../../../../hotels/presentation/screens/hotel_reservation_details_for_manager.dart';
import '../../../../hotels/presentation/screens/hotel_reservation_details_for_user.dart';
import '../../controller/authentication_bloc.dart';
import '../../controller/authentication_event.dart';
import '../../controller/authentication_state.dart';
import '../login/login_screen.dart';
import 'ProfileMenuWidget.dart';
import 'base_update_profile.dart';
import 'settings.dart';

class profile_screen extends StatefulWidget {
  String type = "user";
  profile_screen({
    Key? key,
    required this.type,
  }) : super(key: key);

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
      // print("getImagePath: $getImagePath");
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
                          Text(username,
                              style: const TextStyle(
                                  fontFamily: "aBeeZee",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          const SizedBox(height: 10),
                          Text("${userDetails.email}",
                              style: const TextStyle(
                                  fontFamily: "aBeeZee",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ],
                      )
                    : const Text("welcome",
                        style: TextStyle(fontFamily: "aBeeZee")),
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
                  child: Text(
                    // (AppStrings.editProfile),
                    AppLocalizations.of(context)!.translate("Edit Profile"),
                    style: TextStyle(
                        fontFamily:
                            sharedPreferences!.getString("Language") == "AR"
                                ? "Mag"
                                : "rye",
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize:
                            sharedPreferences!.getString("Language") == "AR"
                                ? 14
                                : 16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: AppLocalizations.of(context)!.translate("Settings"),
                  icon: Icons.settings,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SSSettings()));
                  }),
              ProfileMenuWidget(
                  title: AppLocalizations.of(context)!
                      .translate("Hotel Reservations"),
                  icon: Icons.list_alt_rounded,
                  onPress: () {
                    sharedPreferences!.getBool("is_manager") == true
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HotelsReservationDetailsForManager()))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HotelsReservationDetailsForUser()));
                  }),
              widget.type == "manger"
                  ? ProfileMenuWidget(
                      title:
                          AppLocalizations.of(context)!.translate("Secan QR"),
                      icon: Icons.qr_code_scanner,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QRViewExample()));
                      })
                  : Container(),
              ProfileMenuWidget(
                  title: AppLocalizations.of(context)!.translate("Information"),
                  icon: Icons.info,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutScreen()));
                  }),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return ProfileMenuWidget(
                      title: AppLocalizations.of(context)!.translate("Logout"),
                      icon: Icons.logout_outlined,
                      endIcon: false,
                      onPress: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(LogoutEvent());
                        AccessToken accessToken = AccessToken();
                        accessToken.saveToken("0");
                        Navigator.pushReplacement(
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
  } else if (imagePath.contains("https")) {
    return Image.network(
      imagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          AppStrings.error1Gif,
          fit: BoxFit.cover,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress != null) {
          return Image.asset(
            AppStrings.loading1Gif,
            fit: BoxFit.cover,
          );
        }
        return child;
      },
    );
  } else {
    return Image.asset(
      AppStrings.profileImage,
      fit: BoxFit.cover,
    );
  }
}
