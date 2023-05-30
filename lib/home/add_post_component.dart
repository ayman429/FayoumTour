import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../core/services/services_locator.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';
import '../core/utils/constance/values_manager.dart';
import '../core/utils/enums.dart';
import '../core/utils/snackbar_message.dart';
import '../post/presentation/controller/bloc/post_bloc.dart';

class AddPostComponent extends StatefulWidget {
  @override
  State<AddPostComponent> createState() => _AddPostComponentState();
}

class _AddPostComponentState extends State<AddPostComponent> {
  final TextEditingController _textEditingController = TextEditingController();
  String getImagePath = "";
  List<File> _imageList = [];

  Future<void> updateUIWithImagePath() async {
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
    return BlocProvider(
      create: (context) {
        return getIt<PostBloc>();
      },
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Add Post'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextButton(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      child: Center(
                        child: Text(
                          'Post',
                          style: GoogleFonts.rye(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      List<String> imagesPath = [];
                      for (int i = 0; i < _imageList.length; i++) {
                        imagesPath.add(_imageList[i].path);
                      }

                      String body = "";
                      body = _textEditingController.text;
                      BlocProvider.of<PostBloc>(context).add(AddPostEvent(
                        body: body,
                        images: imagesPath,
                      ));
                      print("---------------------------");
                      print(imagesPath);
                      _textEditingController.clear();
                      setState(() {
                        _imageList = [];
                      });
                      // Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                left: 6,
                right: 6,
                top: 40,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: BlocConsumer<PostBloc, PostState>(
                        listener: (context, state) {
                      if (state.addPostState == RequestState.loaded) {
                        print("Post Loded");
                        BlocProvider.of<PostBloc>(context).add(GetPostEvent());
                        print("Post Loded");
                        Navigator.pop(context);
                        // setState(() {
                        //   Navigator.pop(context);
                        // });

                        //   var _selectedOption =
                        //       sharedPreferences!.getString("selectedOption");
                        //   if (_selectedOption != null) {
                        //     Navigator.of(context).pushAndRemoveUntil(
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 BottomBar(select: 1, _selectedOption)),
                        //         (route) => false);
                        //   } else {
                        //     Navigator.of(context).pushAndRemoveUntil(
                        //         MaterialPageRoute(builder: (context) => TourismScreen()),
                        //         (route) => false);
                        //   }
                      } else if (state.addPostState == RequestState.error) {
                        // String message;
                        // message = loginValidationMessage(state.loginMessage);
                        // message = Validation.validationMessage(state.addPostMessage);
                        SnackBarMessage().showErrorSnackBar(
                            message: state.addPostMessage, context: context);
                      }
                    }, builder: (context, state) {
                      if (state.addPostState == RequestState.loading) {
                        print("Post Loding");

                        /// loading
                        // return Text("Processing");
                      }
                      return Container();
                    }),
                  ),

                  Row(children: [
                    // user image
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: displayImage(getImagePath),
                      ),
                    ),

                    const SizedBox(width: 10),
                    // input text post
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: 'Write your post now!',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        maxLines: null,
                        // onChanged: (value) {
                        //   _text = value;
                        // },
                      ),
                    ),
                    // input images post
                    IconButton(
                      color: Colors.green,
                      iconSize: 35,
                      icon: const Icon(Icons.filter),
                      onPressed: () async {
                        {
                          final pickedFile = await showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SafeArea(
                                child: Wrap(
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: const Text('Photo Library'),
                                      onTap: () async {
                                        final pickedFile = await ImagePicker()
                                            .getImage(
                                                source: ImageSource.gallery);
                                        // if (pickedFile != null) {
                                        //   var userId = await FavouritStorage()
                                        //       .getUsersDetails();
                                        //   sharedPreferences!.setString(
                                        //       "${userId.id}USERIMAGE",
                                        //       pickedFile.path);
                                        //   print(
                                        //       "path====> ${pickedFile.path}");
                                        // }
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
                                        // if (pickedFile != null) {
                                        //   var userId = await FavouritStorage()
                                        //       .getUsersDetails();
                                        //   sharedPreferences!.setString(
                                        //       "${userId.id}USERIMAGE",
                                        //       pickedFile.path);
                                        // }
                                        Navigator.pop(context, pickedFile);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                          setState(() {
                            if (pickedFile != null) {
                              _imageList.add(File(pickedFile.path));
                            } else {
                              print('No image selected.');
                            }
                          });
                          // var userId =
                          //     await FavouritStorage().getUsersDetails();

                          // setState(() {
                          //   getImagePath = sharedPreferences!
                          //           .getString("${userId.id}USERIMAGE") ??
                          //       "";
                          // });
                          // BlocProvider.of<AuthenticationBloc>(context)
                          //     .add(UpdateUserDetailsEvent(
                          //         userData: getImagePath,
                          //         // File(getImagePath)
                          //         //     .readAsBytesSync(), //FileImage(File(getImagePath)),
                          //         type: "image"));
                          // setState(() {
                          //   type = "image";
                          // });
                          // // Navigator.pop(context);
                        }
                      },
                    ),
                  ]),
                  // show images selected
                  const SizedBox(height: 10),
                  _imageList.isNotEmpty
                      ? SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _imageList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    _imageList[index],
                                    fit: BoxFit.cover,
                                    width: 100,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 7),
                ],
              ),
            ),
          );
        },
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
