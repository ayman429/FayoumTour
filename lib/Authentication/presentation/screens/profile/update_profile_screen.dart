import 'dart:io';
import 'package:fayoumtour/Authentication/domain/entities/change_password.dart';
import 'package:fayoumtour/core/utils/constance/shared_pref.dart';
import 'package:fayoumtour/core/utils/constance/strings_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/local_data_shared_preferences/favourites_shared_preferences.dart';
import '../../../../core/utils/constance/values_manager.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/snackbar_message.dart';
import '../../components/password_text_form_field.dart';
import '../../components/user_name_text_form_field.dart';
import '../../components/validation.dart';
import '../../controller/authentication_bloc.dart';
import '../../controller/authentication_event.dart';
import '../../controller/authentication_state.dart';

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController password1Controller = TextEditingController();

  TextEditingController password2Controller = TextEditingController();

  String picked__File = "";
  String getImagePath = "";
  Future<void> updateUIWithImagePath() async {
    var userId = await FavouritStorage().getUsersDetails();
    String imagePath =
        sharedPreferences!.getString("${userId.id}USERIMAGE") ?? "";
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
        title: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Row(
            children: [
              const Icon(Icons.edit),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Edit Profile",
                style: GoogleFonts.acme(fontSize: 23),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Container(
                child: Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
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
                          // onTap: _showImagePicker,
                          onTap: () async {
                            final pickedFile = await showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SafeArea(
                                  child: Wrap(
                                    children: <Widget>[
                                      ListTile(
                                        leading:
                                            const Icon(Icons.photo_library),
                                        title: const Text('Photo Library'),
                                        onTap: () async {
                                          final pickedFile = await ImagePicker()
                                              .getImage(
                                                  source: ImageSource.gallery);
                                          if (pickedFile != null) {
                                            var userId = await FavouritStorage()
                                                .getUsersDetails();
                                            sharedPreferences!.setString(
                                                "${userId.id}USERIMAGE",
                                                pickedFile.path);
                                            print(
                                                "path====> ${pickedFile.path}");
                                          }
                                          Navigator.pop(context, pickedFile);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.photo_camera),
                                        title: const Text('Camera'),
                                        onTap: () async {
                                          final pickedFile =
                                              // ignore: deprecated_member_use
                                              await ImagePicker().getImage(
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
                            // Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                  if (state.updateuserDetailsState == RequestState.loaded ||
                      state.changePasswordstate == RequestState.loaded) {
                    print("loaded");

                    Navigator.pop(context);
                  } else if (state.updateuserDetailsState ==
                      RequestState.error) {
                    print("error: ${state.updateuserDetailsMessage}");
                    String message;
                    message = Validation.validationMessage(
                        state.updateuserDetailsMessage);
                    SnackBarMessage()
                        .showErrorSnackBar(message: message, context: context);
                  } else if (state.changePasswordstate == RequestState.error) {
                    print("error: ${state.changePasswordMessage}");
                    String message;
                    message = Validation.validationMessage(
                        state.changePasswordMessage);
                    SnackBarMessage()
                        .showErrorSnackBar(message: message, context: context);
                  }
                }, builder: (context, state) {
                  if (state.updateuserDetailsState == RequestState.loading ||
                      state.changePasswordstate == RequestState.loading) {
                    print("loading");

                    /// loading
                    // return Text("Processing");
                  }
                  return Container();
                }),
              ),
              const SizedBox(height: 50),
              UserNameTextFormField(userNameController: userNameController),
              const SizedBox(height: AppPadding.p16),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                        UpdateUserDetailsEvent(
                            userName: userNameController.text));
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    AppStrings.editName.toUpperCase(),
                    style: GoogleFonts.rye(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ),
              const SizedBox(height: AppPadding.p16),
              PasswordTextFormField(passwordController: password1Controller),
              const SizedBox(height: AppPadding.p16),
              PasswordTextFormField(passwordController: password2Controller),
              const SizedBox(height: AppPadding.p16),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
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
                  child: Text(
                    AppStrings.editPassword.toUpperCase(),
                    style: GoogleFonts.rye(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary),
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
  } else {
    return Image.asset(
      AppStrings.profileImage,
      fit: BoxFit.cover,
    );
  }
}