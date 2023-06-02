import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/services/services_locator.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';
import '../post/presentation/controller/bloc/post_bloc.dart';
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
                  decoration:  BoxDecoration(
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
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        
                        // user image
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
                          padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 10),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  // Navigate to the input screen

                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddPostComponent(
                                          type: "add", data: ""),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.only(left: 40, right: 45),
                                    child: Text(
                                      'Write your post now!',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.filter,color: Colors.green,size: 30,),
                        
                        // const SizedBox(width: 10),
                        // ----------------- input text post -----------------
                        // Expanded(
                        //   child: TextField(
                        //     controller: _textEditingController,
                        //     decoration: InputDecoration(
                        //       hintText: 'Write your post now!',
                        //       border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(30)),
                        //     ),
                        //     maxLines: null,
                        //     // onChanged: (value) {
                        //     //   _text = value;
                        //     // },
                        //   ),
                        // ),

                        // ----------------- input images post ----------------------

                        // IconButton(
                        //   color: Colors.green,
                        //   iconSize: 35,
                        //   icon: const Icon(Icons.filter),
                        //   onPressed: () async {
                        //     {
                        //       final pickedFile = await showModalBottomSheet(
                        //         context: context,
                        //         builder: (BuildContext context) {
                        //           return SafeArea(
                        //             child: Wrap(
                        //               children: <Widget>[
                        //                 ListTile(
                        //                   leading: const Icon(Icons.photo_library),
                        //                   title: const Text('Photo Library'),
                        //                   onTap: () async {
                        //                     final pickedFile = await ImagePicker()
                        //                         .getImage(
                        //                             source: ImageSource.gallery);
                        //                     // if (pickedFile != null) {
                        //                     //   var userId = await FavouritStorage()
                        //                     //       .getUsersDetails();
                        //                     //   sharedPreferences!.setString(
                        //                     //       "${userId.id}USERIMAGE",
                        //                     //       pickedFile.path);
                        //                     //   print(
                        //                     //       "path====> ${pickedFile.path}");
                        //                     // }
                        //                     Navigator.pop(context, pickedFile);
                        //                   },
                        //                 ),
                        //                 ListTile(
                        //                   leading: const Icon(Icons.photo_camera),
                        //                   title: const Text('Camera'),
                        //                   onTap: () async {
                        //                     final pickedFile =
                        //                         // ignore: deprecated_member_use
                        //                         await ImagePicker().getImage(
                        //                             source: ImageSource.camera);
                        //                     // if (pickedFile != null) {
                        //                     //   var userId = await FavouritStorage()
                        //                     //       .getUsersDetails();
                        //                     //   sharedPreferences!.setString(
                        //                     //       "${userId.id}USERIMAGE",
                        //                     //       pickedFile.path);
                        //                     // }
                        //                     Navigator.pop(context, pickedFile);
                        //                   },
                        //                 ),
                        //               ],
                        //             ),
                        //           );
                        //         },
                        //       );
                        //       setState(() {
                        //         if (pickedFile != null) {
                        //           _imageList.add(File(pickedFile.path));
                        //         } else {
                        //           print('No image selected.');
                        //         }
                        //       });
                        //       // var userId =
                        //       //     await FavouritStorage().getUsersDetails();

                        //       // setState(() {
                        //       //   getImagePath = sharedPreferences!
                        //       //           .getString("${userId.id}USERIMAGE") ??
                        //       //       "";
                        //       // });
                        //       // BlocProvider.of<AuthenticationBloc>(context)
                        //       //     .add(UpdateUserDetailsEvent(
                        //       //         userData: getImagePath,
                        //       //         // File(getImagePath)
                        //       //         //     .readAsBytesSync(), //FileImage(File(getImagePath)),
                        //       //         type: "image"));
                        //       // setState(() {
                        //       //   type = "image";
                        //       // });
                        //       // // Navigator.pop(context);
                        //     }
                        //   },
                        // ),
                      ]),
                      
                    ],
                  ),
                ),
                //----------------- show images selected -----------------
                // const SizedBox(height: 10),
                // _imageList.isNotEmpty
                //     ? SizedBox(
                //         height: 120,
                //         child: ListView.builder(
                //           scrollDirection: Axis.horizontal,
                //           itemCount: _imageList.length,
                //           itemBuilder: (context, index) {
                //             return Container(
                //               margin: const EdgeInsets.symmetric(horizontal: 3),
                //               child: ClipRRect(
                //                 borderRadius: BorderRadius.circular(10),
                //                 child: Image.file(
                //                   _imageList[index],
                //                   fit: BoxFit.cover,
                //                   width: 100,
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //       )
                //     : const SizedBox.shrink(),
                // const SizedBox(height: 7),
                //----------------------------------
                //-------------------------------------
                // ------------------ post it ---------------------------------
                // BlocProvider(
                //   create: (context) {
                //     return getIt<PostBloc>();
                //   },
                //   child: BlocBuilder<PostBloc, PostState>(
                //     builder: (context, state) {
                //       return InkWell(
                //         child: Container(
                //           height: 45,
                //           decoration: BoxDecoration(
                //             color: Colors.green,
                //             borderRadius: BorderRadius.circular(15.0),
                //           ),
                //           margin: const EdgeInsets.symmetric(horizontal: 0),
                //           child: Center(
                //             child: Text(
                //               'Post',
                //               style: GoogleFonts.rye(
                //                   fontSize: 20, color: Colors.white),
                //             ),
                //           ),
                //         ),
                //         onTap: () async {
                //           // dynamic images;
                //           // FormData formData = FormData();
                //           // List images=[];
                //           // for (int i = 0; i < _imageList.length; i++) {
                //           //   String imagePath = _imageList[i].path;
                //           //   images.add(MultipartFile.fromFile(imagePath));
                //           // }
                //           List<String> imagesPath = [];
                //           for (int i = 0; i < _imageList.length; i++) {
                //             imagesPath.add(_imageList[i].path);
                //           }
                //           // int user = int.parse(
                //           //     sharedPreferences!.getString("USERID") ?? "0");
                //           // if (user != 0) {
                //           // Post post = Post(
                //           //     user: user,
                //           //     body: _textEditingController.text,
                //           //     imagesP: []);
                //           String body = "";
                //           body = _textEditingController.text;
                //           BlocProvider.of<PostBloc>(context).add(AddPostEvent(
                //             body: body,
                //             images: imagesPath,
                //           ));
                //           _textEditingController.clear();
                //           setState(() {
                //             _imageList = [];
                //           });

                //           // }

                //           //_imageList
                //           /*MultipartFile.fromFile(userData)
                //                                        FormData formData = FormData();

                //                                         // Add the images to the form data
                //                                         for (int i = 0; i < imagePaths.length; i++) {
                //                                           String imagePath = imagePaths[i];
                //                                           formData.files.add(MapEntry(
                //                                             'images',
                //                                             await MultipartFile.fromFile(
                //                                               imagePath,
                //                                               filename: 'image_$i.jpg', // Set the desired filenames
                //                                             ),
                //                                           ));
                //                                         }
                //                                        */

                //           // setState(() {
                //           //   try {
                //           //     FirebaseFirestore.instance.collection("Posts").add({
                //           //       "Email": user.email,
                //           //       "Text": _text,
                //           //       "images": _imageList,
                //           //       "Name":
                //           //           '${snap.data?.docs[0]["FirstName"]} ${snap.data?.docs[0]["LastName"]}',
                //           //       "image": snap.data?.docs[0]["image"],
                //           //       "Time": DateTime.now().toString()
                //           //     }).then((DocumentReference doc) {
                //           //       FirebaseFirestore.instance
                //           //           .collection("Posts")
                //           //           .doc(doc.id)
                //           //           .update({
                //           //         "iid": doc.id,
                //           //       });
                //           //     });
                //           //   } on FirebaseAuthException catch (m) {
                //           //     showDialog(
                //           //         context: context,
                //           //         barrierDismissible: false,
                //           //         builder: (context) {
                //           //           return AlertDialog(
                //           //             title: Text(
                //           //               m.message.toString(),
                //           //               style: GoogleFonts.merriweather(),
                //           //             ),
                //           //             actions: [
                //           //               Center(
                //           //                 child: ElevatedButton(
                //           //                     onPressed: () {
                //           //                       Navigator.of(context).pop();
                //           //                     },
                //           //                     child: Text(
                //           //                       "Okay",
                //           //                       style: GoogleFonts.rye(
                //           //                           color: Theme.of(context)
                //           //                               .colorScheme
                //           //                               .onSecondary),
                //           //                     ),
                //           //                     style: ElevatedButton.styleFrom(
                //           //                       backgroundColor: Theme.of(context)
                //           //                           .colorScheme
                //           //                           .primary,
                //           //                       shape: RoundedRectangleBorder(
                //           //                           borderRadius:
                //           //                               BorderRadius.circular(15)),
                //           //                     )),
                //           //               )
                //           //             ],
                //           //             shape: RoundedRectangleBorder(
                //           //                 borderRadius: BorderRadius.circular(15)),
                //           //           );
                //           //         });
                //           //   }
                //           //   _textEditingController.clear();
                //           //   _text = "";
                //           //   _imageList = [];
                //           // });
                //         },
                //       );
                //     },
                //   ),
                // ),
              ],
            ),

            // const SizedBox(height: 10),
            // show posts
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
