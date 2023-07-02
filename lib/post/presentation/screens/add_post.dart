import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/constance/strings_manager.dart';
import '../controller/bloc/post_bloc.dart';
import 'add_post_component.dart';
import 'show_posts.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _textEditingController = TextEditingController();
  String getImagePath = "";
  final List<File> _imageList = [];

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
  Widget build(context) {
    return BlocProvider(
      create: (context) {
        return getIt<PostBloc>()..add(GetPostEvent());
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            // add posts
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // user image
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: displayImage(getImagePath),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 10),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          // Navigate to the input screen

                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddPostComponent(
                                                      type: "add", data: ""),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.742,
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              '   Write your post now!   ',
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Container(
                                margin: const EdgeInsets.only(right: 5),
                                child: const Icon(
                                  Icons.filter,
                                  color: Colors.green,
                                  size: 30,
                                )),
                          ]),
                    ],
                  ),
                ),
              ],
            ),
            const SingleChildScrollView(
              child: ShowPosts(),
            ),
          ],
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
