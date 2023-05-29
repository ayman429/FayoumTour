import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../core/services/services_locator.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';
import '../core/utils/enums.dart';
import '../post/presentation/controller/bloc/post_bloc.dart';
import 'image_list.dart';

class AddPost extends StatefulWidget {
  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
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
        return getIt<PostBloc>()..add(GetPostEvent());
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            // add posts
            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                children: [
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
                  // post it
                  InkWell(
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
                    onTap: () {
                      // setState(() {
                      //   try {
                      //     FirebaseFirestore.instance.collection("Posts").add({
                      //       "Email": user.email,
                      //       "Text": _text,
                      //       "images": _imageList,
                      //       "Name":
                      //           '${snap.data?.docs[0]["FirstName"]} ${snap.data?.docs[0]["LastName"]}',
                      //       "image": snap.data?.docs[0]["image"],
                      //       "Time": DateTime.now().toString()
                      //     }).then((DocumentReference doc) {
                      //       FirebaseFirestore.instance
                      //           .collection("Posts")
                      //           .doc(doc.id)
                      //           .update({
                      //         "iid": doc.id,
                      //       });
                      //     });
                      //   } on FirebaseAuthException catch (m) {
                      //     showDialog(
                      //         context: context,
                      //         barrierDismissible: false,
                      //         builder: (context) {
                      //           return AlertDialog(
                      //             title: Text(
                      //               m.message.toString(),
                      //               style: GoogleFonts.merriweather(),
                      //             ),
                      //             actions: [
                      //               Center(
                      //                 child: ElevatedButton(
                      //                     onPressed: () {
                      //                       Navigator.of(context).pop();
                      //                     },
                      //                     child: Text(
                      //                       "Okay",
                      //                       style: GoogleFonts.rye(
                      //                           color: Theme.of(context)
                      //                               .colorScheme
                      //                               .onSecondary),
                      //                     ),
                      //                     style: ElevatedButton.styleFrom(
                      //                       backgroundColor: Theme.of(context)
                      //                           .colorScheme
                      //                           .primary,
                      //                       shape: RoundedRectangleBorder(
                      //                           borderRadius:
                      //                               BorderRadius.circular(15)),
                      //                     )),
                      //               )
                      //             ],
                      //             shape: RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(15)),
                      //           );
                      //         });
                      //   }
                      //   _textEditingController.clear();
                      //   _text = "";
                      //   _imageList = [];
                      // });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // show posts
            SingleChildScrollView(child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                switch (state.postState) {
                  case RequestState.loading:
                    return const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()));
                  case RequestState.loaded:
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.post.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 241, 241, 241),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      // user image in post
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: (state.post[index].createdBy!
                                                      .image !=
                                                  "")
                                              ? Image.network(
                                                  state.post[index].createdBy!
                                                      .image,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.asset(
                                                      AppStrings.error1Gif,
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress !=
                                                        null) {
                                                      return Image.asset(
                                                        AppStrings.loading1Gif,
                                                        fit: BoxFit.cover,
                                                      );
                                                    }
                                                    return child;
                                                  },
                                                )
                                              : Image.file(
                                                  File(getImagePath),
                                                  fit: BoxFit.cover,
                                                )),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${state.post[index].createdBy!.userName}',
                                            style: GoogleFonts.aBeeZee(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          // Text(
                                          //   snapshot.data?.docs[index]["Time"],
                                          //   style: const TextStyle(
                                          //     color: Colors.grey,
                                          //     fontSize: 14,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          // DocumentReference documentReference =
                                          //     FirebaseFirestore.instance
                                          //         .collection('Posts')
                                          //         .doc(snapshot
                                          //             .data?.docs[index].id);
                                          // documentReference.delete();
                                        },
                                        icon: const Icon(Icons.cancel))
                                  ],
                                ),
                              ),
                              state.post[index].body == ""
                                  ? const SizedBox(
                                      height: 10,
                                    )
                                  : Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 12),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          state.post[index].body,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            //fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                              state.post[index].imagesP.isNotEmpty
                                  ? SizedBox(
                                      height: 360,
                                      child: GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate: state.post[index].imagesP
                                                    .length ==
                                                1
                                            ? SliverQuiltedGridDelegate(
                                                crossAxisCount: 1,
                                                pattern: [
                                                    const QuiltedGridTile(1, 1)
                                                  ])
                                            : state.post[index].imagesP
                                                        .length ==
                                                    2
                                                ? SliverQuiltedGridDelegate(
                                                    crossAxisCount: 2,
                                                    pattern: [
                                                      const QuiltedGridTile(
                                                          2, 1),
                                                      const QuiltedGridTile(
                                                          2, 1)
                                                    ],
                                                    mainAxisSpacing: 3,
                                                    crossAxisSpacing: 3)
                                                : state.post[index].imagesP
                                                            .length ==
                                                        3
                                                    ? SliverQuiltedGridDelegate(
                                                        crossAxisCount: 2,
                                                        pattern: [
                                                          const QuiltedGridTile(
                                                              2, 1),
                                                          const QuiltedGridTile(
                                                              1, 1),
                                                          const QuiltedGridTile(
                                                              1, 1)
                                                        ],
                                                        mainAxisSpacing: 3,
                                                        crossAxisSpacing: 3)
                                                    : SliverQuiltedGridDelegate(
                                                        crossAxisCount: 2,
                                                        pattern: [
                                                          const QuiltedGridTile(
                                                              1, 1),
                                                          const QuiltedGridTile(
                                                              1, 1)
                                                        ],
                                                        mainAxisSpacing: 3,
                                                        crossAxisSpacing: 3),
                                        itemCount:
                                            state.post[index].imagesP.length,
                                        itemBuilder: (context, x) {
                                          if (x < 4) {
                                            if (x == 3) {
                                              return InkWell(
                                                onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ImageList(
                                                                imageList: state
                                                                    .post[index]
                                                                    .imagesP,
                                                                index: x))),
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    Opacity(
                                                      opacity: state
                                                                  .post[index]
                                                                  .imagesP
                                                                  .length >
                                                              4
                                                          ? 0.6
                                                          : 1.0,
                                                      child: ClipRRect(
                                                        //borderRadius:BorderRadius.circular(10),
                                                        child: Image.network(
                                                          state
                                                              .post[index]
                                                              .imagesP[index]
                                                              .imageT,
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Image.asset(
                                                              AppStrings
                                                                  .error1Gif,
                                                              fit: BoxFit.cover,
                                                            );
                                                          },
                                                          loadingBuilder: (context,
                                                              child,
                                                              loadingProgress) {
                                                            if (loadingProgress !=
                                                                null) {
                                                              return Image
                                                                  .asset(
                                                                AppStrings
                                                                    .loading2Gif,
                                                                fit: BoxFit
                                                                    .cover,
                                                              );
                                                            }
                                                            return child;
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    state.post[index].imagesP
                                                                .length >
                                                            4
                                                        ? Center(
                                                            child: Text(
                                                              "+${state.post[index].imagesP.length - 4}",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 40,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return InkWell(
                                                onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ImageList(
                                                                imageList: state
                                                                    .post[index]
                                                                    .imagesP,
                                                                index: x))),
                                                child: ClipRRect(
                                                  //borderRadius:BorderRadius.circular(10),
                                                  child: Image.network(
                                                    state.post[index].imagesP[x]
                                                        .imageT,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        AppStrings.error1Gif,
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress !=
                                                          null) {
                                                        return Image.asset(
                                                          AppStrings
                                                              .loading2Gif,
                                                          fit: BoxFit.cover,
                                                        );
                                                      }
                                                      return child;
                                                    },
                                                  ),
                                                ),
                                              );
                                            }
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        );
                      },
                    );

                  case RequestState.error:
                    print("error-------------->");
                    return Container();
                }
              },
            )),
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
  } else {
    return Image.asset(
      AppStrings.profileImage,
      fit: BoxFit.cover,
    );
  }
}
