import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/constance/strings_manager.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/snackbar_message.dart';
import '../controller/bloc/post_bloc.dart';

class AddPostComponent extends StatefulWidget {
  String type;
  var data;
  AddPostComponent({
    Key? key,
    required this.type,
    required this.data,
  }) : super(key: key);
  @override
  State<AddPostComponent> createState() => _AddPostComponentState();
}

class _AddPostComponentState extends State<AddPostComponent> {
  final TextEditingController _textEditingController = TextEditingController();

  String getImagePath = "";
  String _text = "";
  List<File> _imageList = [];
  final username = sharedPreferences!.getString("username") ?? "";
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
    if (widget.type != 'add') {
      _textEditingController.text = widget.data.body;
    }

    updateUIWithImagePath();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return getIt<PostBloc>();
      },
      child: BlocListener<PostBloc, PostState>(
        listenWhen: (previous, current) =>
            previous.postState != current.postState,
        listener: (context, state) {
          print(state.postState);
          BlocProvider.of<PostBloc>(context).add(GetPostEvent());
        },
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text(widget.type == 'add' ? "Create Post" : "Edit Post"),
                actions: [
                  Opacity(
                    opacity: _textEditingController.text == "" &&
                            _imageList.isEmpty
                        ? 0.5
                        : widget.type == 'add'
                            ? 1
                            : _textEditingController.text == widget.data.body &&
                                    _imageList.isEmpty
                                ? 0.5
                                : 1,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 6, 8, 6),
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextButton(
                        child: Center(
                          child: Text(
                            widget.type == 'add' ? 'Post' : "Update",
                            style: GoogleFonts.rye(
                                fontSize: 17,
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                          ),
                        ),
                        onPressed: () async {
                          if (_textEditingController.text != "" ||
                              _imageList.isNotEmpty) {
                            List<String> imagesPath = [];
                            for (int i = 0; i < _imageList.length; i++) {
                              imagesPath.add(_imageList[i].path);
                            }

                            String body = "";
                            body = _textEditingController.text;
                            if (widget.type == "add") {
                              BlocProvider.of<PostBloc>(context)
                                  .add(AddPostEvent(
                                body: body,
                                images: imagesPath,
                              ));
                            } else if (widget.type == "edit") {
                              BlocProvider.of<PostBloc>(context)
                                  .add(UpdatePostEvent(
                                body: body,
                                images: imagesPath,
                                posId: widget.data.id.toString(),
                              ));
                            }

                            print("---------------------------");
                            print(imagesPath);
                            _textEditingController.clear();
                            setState(() {
                              _imageList = [];
                            });
                            // Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ),
                ],
                //centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 6, right: 6, top: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0 //AppPadding.p16
                            ),
                        child: BlocConsumer<PostBloc, PostState>(
                            listener: (context, state) {
                          if (state.addPostState == RequestState.loaded ||
                              state.updatePostState == RequestState.loaded) {
                            print("Post Loded");
                            BlocProvider.of<PostBloc>(context)
                                .add(GetPostEvent());
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
                          } else if (state.addPostState == RequestState.error ||
                              state.updatePostState == RequestState.error) {
                            // String message;
                            // message = loginValidationMessage(state.loginMessage);
                            // message = Validation.validationMessage(state.addPostMessage);
                            SnackBarMessage().showErrorSnackBar(
                                message: state.addPostMessage,
                                context: context);
                          }
                        }, builder: (context, state) {
                          if (state.addPostState == RequestState.loading ||
                              state.updatePostState == RequestState.loading) {
                            print("Post Loding");

                            /// loading
                            // return Text("Processing");
                          }
                          return Container();
                        }),
                      ),

                      // user image
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: displayImage(getImagePath),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                username,
                                style: GoogleFonts.aBeeZee(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
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
                                            leading:
                                                const Icon(Icons.photo_library),
                                            title: const Text('Photo Library'),
                                            onTap: () async {
                                              final pickedFile =
                                                  await ImagePicker().pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              // if (pickedFile != null) {
                                              //   var userId = await FavouritStorage()
                                              //       .getUsersDetails();
                                              //   sharedPreferences!.setString(
                                              //       "${userId.id}USERIMAGE",
                                              //       pickedFile.path);
                                              //   print(
                                              //       "path====> ${pickedFile.path}");
                                              // }
                                              Navigator.pop(
                                                  context, pickedFile);
                                            },
                                          ),
                                          ListTile(
                                            leading:
                                                const Icon(Icons.photo_camera),
                                            title: const Text('Camera'),
                                            onTap: () async {
                                              final pickedFile =
                                                  // ignore: deprecated_member_use
                                                  await ImagePicker().pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              // if (pickedFile != null) {
                                              //   var userId = await FavouritStorage()
                                              //       .getUsersDetails();
                                              //   sharedPreferences!.setString(
                                              //       "${userId.id}USERIMAGE",
                                              //       pickedFile.path);
                                              // }
                                              Navigator.pop(
                                                  context, pickedFile);
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
                        ],
                      ),

                      const SizedBox(height: 10),
                      // input text post
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Expanded(
                          child: TextFormField(
                            style: const TextStyle(fontSize: 25),
                            // initialValue: widget.data.body.toString(),
                            controller: _textEditingController,
                            decoration: const InputDecoration(
                              hintText: 'Write your post now!',
                              // border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(30)),
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                            onChanged: (value) {
                              if ((_text == "" && value != "") ||
                                  (_text != "" && value == "")) {
                                setState(() {});
                              }

                              if (widget.type != 'add') {
                                if ((_text == widget.data.body &&
                                        value != widget.data.body) ||
                                    value == widget.data.body) {
                                  setState(() {});
                                }
                              }
                              _text = value;
                            },
                          ),
                        ),
                      ),

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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: Stack(
                                      fit: StackFit.passthrough,
                                      children: [
                                        ShaderMask(
                                          shaderCallback: (rect) {
                                            return const LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.transparent,
                                                Colors.black,
                                                Colors.black,
                                                Colors.transparent,
                                              ],
                                              stops: [0, 0.3, 1, 1],
                                            ).createShader(Rect.fromLTRB(
                                                0, 0, rect.width, rect.height));
                                          },
                                          blendMode: BlendMode.dstIn,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(
                                              _imageList[index],
                                              fit: BoxFit.cover,
                                              width: 100,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _imageList.removeAt(index);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.cancel,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                )),
                                          ],
                                        )
                                      ],
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
              ),
            );
          },
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
