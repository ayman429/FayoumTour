import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/constance/strings_manager.dart';
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
  Widget build(context) {
    return SingleChildScrollView(
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
                                padding:
                                    sharedPreferences!.getString("Language") ==
                                            "AR"
                                        ? const EdgeInsets.only(right: 5)
                                        : const EdgeInsets.only(left: 5),
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: FutureBuilder(
                                        future: updateUIWithImagePath(),
                                        builder: (context, snapshot) =>
                                            displayImage(getImagePath)),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 10),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Navigate to the input screen

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddPostComponent(
                                                    type: "add", data: ""),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.742,
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Center(
                                          child: sharedPreferences!
                                                      .getBool("is_manager") ==
                                                  true
                                              ? Text(
                                                  // '   write your offer now!   ',
                                                  AppLocalizations.of(context)!
                                                      .translate(
                                                          "   write your offer now!   "),
                                                  style: const TextStyle(
                                                      fontSize: 18.0,
                                                      fontFamily: "amiri"),
                                                )
                                              : Text(
                                                  // '   Write your post now!   ',
                                                  AppLocalizations.of(context)!
                                                      .translate(
                                                          "   Write your post now!   "),
                                                  style: const TextStyle(
                                                      fontSize: 18.0,
                                                      fontFamily: "amiri"),
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
                              margin:
                                  sharedPreferences!.getString("Language") ==
                                          "AR"
                                      ? const EdgeInsets.only(left: 5)
                                      : const EdgeInsets.only(right: 5),
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
      fadeInDuration: const Duration(milliseconds: 350),
      fadeOutDuration: const Duration(milliseconds: 350),
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
