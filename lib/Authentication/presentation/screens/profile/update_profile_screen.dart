import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fayoumtour/Authentication/domain/entities/change_password.dart';
import 'package:fayoumtour/Authentication/domain/entities/user_details.dart';
import 'package:fayoumtour/core/utils/constance/shared_pref.dart';
import 'package:fayoumtour/core/utils/constance/strings_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/local_data_shared_preferences/favourites_shared_preferences.dart';
import '../../../../core/utils/app_localizations.dart';
import '../../../../core/utils/constance/values_manager.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/snackbar_message.dart';
import '../../components/password_text_form_field.dart';
import '../../components/validation.dart';
import '../../controller/authentication_bloc.dart';
import '../../controller/authentication_event.dart';
import '../../controller/authentication_state.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController password1Controller = TextEditingController();

  TextEditingController password2Controller = TextEditingController();

  String picked__File = "";
  String getImagePath = "";
  String type = "";
  Future<void> updateUIWithImagePath() async {
    // var userId = await FavouritStorage().getUsersDetails();
    // String imagePath =
    //     sharedPreferences!.getString("${userId.id}USERIMAGE") ?? "";
    Map<String, dynamic> localUerDetails =
        json.decode(sharedPreferences!.getString("USER") ?? "");

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.translate("Edit Profile"),
            style: sharedPreferences!.getString("Language") == "AR"
                ? TextStyle(
                    fontFamily: "galaxy",
                    fontWeight: FontWeight.bold,
                    fontSize:
                        (28 / 360) * MediaQuery.of(context).size.width, //28,
                  )
                : TextStyle(
                    fontFamily: AppStrings.fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize:
                        (25 / 360) * MediaQuery.of(context).size.width, //25,
                  )),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width:
                        (120 / 360) * MediaQuery.of(context).size.width, //120,
                    height:
                        (120 / 360) * MediaQuery.of(context).size.width, //120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: displayImage(getImagePath),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context).colorScheme.primary),
                      child: InkWell(
                        child: Icon(
                          Icons.edit,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 20,
                        ),
                        // onTap: _showImagePicker ,
                        onTap: () async {
                          final pickedFile = await showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SafeArea(
                                child: Wrap(
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: Text(AppLocalizations.of(context)!
                                          .translate('Photo Library')),
                                      onTap: () async {
                                        final pickedFile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        if (pickedFile != null) {
                                          var userId = await FavouritStorage()
                                              .getUsersDetails();
                                          sharedPreferences!.setString(
                                              "${userId.id}USERIMAGE",
                                              pickedFile.path);
                                          //print("path====> ${pickedFile.path}");
                                        }
                                        Navigator.pop(context, pickedFile);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.photo_camera),
                                      title: Text(AppLocalizations.of(context)!
                                          .translate('Camera')),
                                      onTap: () async {
                                        final pickedFile =
                                            // ignore: deprecated_member_use
                                            await ImagePicker().pickImage(
                                                source: ImageSource.camera);
                                        if (pickedFile != null) {
                                          var userId = await FavouritStorage()
                                              .getUsersDetails();
                                          sharedPreferences!.setString(
                                              "${userId.id}USERIMAGE",
                                              pickedFile.path);
                                        }
                                        Navigator.pop(context, pickedFile);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                          var userId =
                              await FavouritStorage().getUsersDetails();

                          setState(() {
                            getImagePath = sharedPreferences!
                                    .getString("${userId.id}USERIMAGE") ??
                                "";
                          });
                          UserDetails userDetails =
                              UserDetails(image: getImagePath);
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(UpdateUserDetailsEvent(
                                  userDetails: userDetails,
                                  // File(getImagePath)
                                  //     .readAsBytesSync(), //FileImage(File(getImagePath)),
                                  type: "image"));
                          setState(() {
                            type = "image";
                          });
                          // Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                  if (state.updateuserDetailsState == RequestState.loaded ||
                      state.changePasswordstate == RequestState.loaded) {
                    //print("loaded");
                    Navigator.pop(context);
                    setState(() {
                      password1Controller.clear();
                      password2Controller.clear();
                    });
                    if (state.changePasswordstate == RequestState.loaded) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text(
                              sharedPreferences!.getString("Language") == "AR"
                                  ? 'تم تغيير الرقم السري بنجاح'
                                  : 'password changed successfully',
                              style: sharedPreferences!.getString("Language") ==
                                      "AR"
                                  ? const TextStyle(fontFamily: "messiri")
                                  : const TextStyle(fontFamily: "merriweather"),
                            ),
                            actions: <Widget>[
                              Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate("Okay"),
                                      style: TextStyle(
                                          fontFamily: sharedPreferences!
                                                      .getString("Language") ==
                                                  "AR"
                                              ? "Mag"
                                              : "rye",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary),
                                    )),
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          );
                        },
                      );
                    }

                    if (state.updateuserDetailsState == RequestState.loaded &&
                        type == "username") {
                      String username = state.updateuserDetails ?? "";
                      sharedPreferences!.setString("username", username);
                      // Navigator.pop(context);
                      //Navigator.pop(context);
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text(
                              sharedPreferences!.getString("Language") == "AR"
                                  ? 'تم تغيير الاسم بنجاح'
                                  : 'username changed successfully',
                              style: sharedPreferences!.getString("Language") ==
                                      "AR"
                                  ? const TextStyle(fontFamily: "messiri")
                                  : const TextStyle(fontFamily: "merriweather"),
                            ),
                            actions: <Widget>[
                              Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate("Okay"),
                                      style: TextStyle(
                                          fontFamily: sharedPreferences!
                                                      .getString("Language") ==
                                                  "AR"
                                              ? "Mag"
                                              : "rye",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary),
                                    )),
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          );
                        },
                      );
                    }
                  } else if (state.updateuserDetailsState ==
                      RequestState.error) {
                    //print("error: ${state.updateuserDetailsMessage}");
                    Navigator.pop(context);
                    String message;
                    message = Validation.validationMessage(
                        state.updateuserDetailsMessage);
                    SnackBarMessage()
                        .showErrorSnackBar(message: message, context: context);
                  } else if (state.changePasswordstate == RequestState.error) {
                    //print("error: ${state.changePasswordMessage}");
                    Navigator.pop(context);
                    String message;
                    message = Validation.validationMessage(
                        state.changePasswordMessage);
                    SnackBarMessage()
                        .showErrorSnackBar(message: message, context: context);
                  }
                }, builder: (context, state) {
                  // if (state.updateuserDetailsState == RequestState.loading ||
                  //     state.changePasswordstate == RequestState.loading) {
                  //   //print("loading");

                  //   /// loading
                  //   // return Text("Processing");
                  // }
                  return Container();
                }),
              ),
              const SizedBox(height: 50),
              // UserNameTextFormField(userNameController: userNameController),
              TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                // cursorColor: ColorManager.kPrimaryColor,
                controller: userNameController,
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(context)!.translate("Your name"),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(AppPadding.p16),
                    child: Icon(Icons.person),
                  ),
                  hintStyle: TextStyle(
                      fontSize: (16 / 360) * MediaQuery.of(context).size.width,
                      fontFamily: "readPro"),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p16, vertical: AppPadding.p16),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                onChanged: (value) {
                  setState(() {
                    // userNameController.text = value;
                  });
                },
              ),

              const SizedBox(height: AppPadding.p16),
              SizedBox(
                width: double.infinity,
                child: Opacity(
                  opacity: userNameController.text == "" ? 0.5 : 1,
                  child: TextButton(
                    onPressed: () {
                      if (userNameController.text != "") {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (ctx) => const FractionallySizedBox(
                            widthFactor:
                                0.5, // Set the desired width factor (0.0 to 1.0)
                            child: AlertDialog(
                              content: SizedBox(
                                width: double.infinity,
                                height: 30,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        );
                        UserDetails userDetails =
                            UserDetails(username: userNameController.text);
                        BlocProvider.of<AuthenticationBloc>(context).add(
                            UpdateUserDetailsEvent(
                                userDetails: userDetails, type: "username"));
                        setState(() {
                          type = "username";
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        AppLocalizations.of(context)!.translate("EDIT NAME"),
                        style: TextStyle(
                            fontFamily:
                                sharedPreferences!.getString("Language") == "AR"
                                    ? "Mag"
                                    : "rye",
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppPadding.p16),
              PasswordTextFormField(
                passwordController: password1Controller,
                isConfirm: false,
              ),
              const SizedBox(height: AppPadding.p16),
              PasswordTextFormField(
                passwordController: password2Controller,
                isConfirm: true,
              ),
              const SizedBox(height: AppPadding.p16),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (ctx) => const FractionallySizedBox(
                        widthFactor:
                            0.5, // Set the desired width factor (0.0 to 1.0)
                        child: AlertDialog(
                          content: SizedBox(
                            width: double.infinity,
                            height: 30,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                    );
                    ChangePassword changePassword = ChangePassword(
                        new_password1: password1Controller.text,
                        new_password2: password2Controller.text);
                    BlocProvider.of<AuthenticationBloc>(context).add(
                        ChangePasswordEvent(changePassword: changePassword));
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      AppLocalizations.of(context)!.translate("EDIT PASSWORD"),
                      style: TextStyle(
                          fontFamily:
                              sharedPreferences!.getString("Language") == "AR"
                                  ? "Mag"
                                  : "rye",
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
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
    return CachedNetworkImage(
      imageUrl: imagePath,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 50),
      fit: BoxFit.cover,
      placeholder: (context, url) {
        return Image.asset(
          AppStrings.profileImage,
          fit: BoxFit.cover,
        );
      },
      errorWidget: (context, url, error) {
        return Image.asset(
          AppStrings.error1Gif,
          fit: BoxFit.cover,
        );
      },
    )
        // Image.network(
        //   imagePath,
        //   fit: BoxFit.cover,
        //   errorBuilder: (context, error, stackTrace) {
        //     return Image.asset(
        //       AppStrings.error1Gif,
        //       fit: BoxFit.cover,
        //     );
        //   },
        //   loadingBuilder: (context, child, loadingProgress) {
        //     if (loadingProgress != null) {
        //       return Image.asset(
        //         AppStrings.loading1Gif,
        //         fit: BoxFit.cover,
        //       );
        //     }
        //     return child;
        //   },
        // ),
        ;
  } else {
    return Image.asset(
      AppStrings.profileImage,
      fit: BoxFit.cover,
    );
  }
}
