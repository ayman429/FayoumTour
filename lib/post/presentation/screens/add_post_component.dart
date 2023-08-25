import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fayoumtour/post/presentation/screens/AR_EN_Post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_format/date_format.dart';

import '../../../core/notification/add notification.dart';
import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/constance/strings_manager.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/snackbar_message.dart';
import '../../domain/entities/post_data.dart';
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
  bool upload = false;
  bool changeInImages = false;
  final List<File> _imageList = [];
  List<XFile> pickedFiles = [];
  final List<String> _providedimageList = [];
  final List<int> _removedProvidedimageIndexList = [];
  TextDirection theTextDirection =
      sharedPreferences!.getString("Language") == "AR"
          ? TextDirection.rtl
          : TextDirection.ltr;
  final username = sharedPreferences!.getString("username") ?? "";
  String userId = sharedPreferences!.getString("USERID") ?? "0";
  final userImage = sharedPreferences!
      .getString("${sharedPreferences!.getString("USERID")}USERIMAGE");
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
      if(isEnglish(widget.data.body))
      {
        theTextDirection = TextDirection.ltr;
      }
      else
      {
        theTextDirection = TextDirection.rtl;
      }
      for (int i = 0; i < widget.data.imagesP.length; i++) {
        _providedimageList.add(widget.data.imagesP[i].imageT);
      }
    }
    updateUIWithImagePath();
    _textEditingController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_textEditingController.selection.baseOffset == 0 &&
        _textEditingController.selection.extentOffset ==
            _textEditingController.text.length) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
                widget.type == 'add'
                    ? AppLocalizations.of(context)!.translate("Create Post")
                    : AppLocalizations.of(context)!.translate("Edit Post"),
                style: sharedPreferences!.getString("Language") == "AR"
                    ? TextStyle(
                        fontFamily: "galaxy",
                        fontWeight: FontWeight.bold,
                        fontSize:
                            (28 / 360) * MediaQuery.of(context).size.width, //28
                      )
                    : TextStyle(
                        fontFamily: AppStrings.fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            (25 / 360) * MediaQuery.of(context).size.width, //25
                      )),
            actions: [
              Opacity(
                opacity: _textEditingController.text
                                .replaceAll("\n", "")
                                .replaceAll(" ", "") ==
                            "" &&
                        _imageList.isEmpty &&
                        widget.type == 'add'
                    ? 0.5
                    : widget.type != "add"
                        ? _textEditingController.text == widget.data.body &&
                                !changeInImages
                            ? 0.5
                            : _textEditingController.text
                                            .replaceAll("\n", "")
                                            .replaceAll(" ", "") ==
                                        "" &&
                                    _imageList.isEmpty &&
                                    _providedimageList.isEmpty
                                ? 0.5
                                : 1
                        : 1,
                child: Container(
                  margin: sharedPreferences!.getString("Language") == "AR"
                      ? const EdgeInsets.fromLTRB(8, 6, 0, 6)
                      : const EdgeInsets.fromLTRB(0, 6, 8, 6),
                  height: (45 / 772) * MediaQuery.of(context).size.height, //45,
                  width: (100 / 360) * MediaQuery.of(context).size.width, //100,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: BlocConsumer<PostBloc, PostState>(
                    listener: (context, state) async {
                      if (state.addPostState == RequestState.loaded ||
                          state.updatePostState == RequestState.loaded) {
                        //print("Post Loded");
                        BlocProvider.of<PostBloc>(context).add(GetPostEvent());
                        //print("Post Loded");
                        Navigator.pop(context);
                        Navigator.pop(context);

                        if (state.addPostState == RequestState.loaded) {
                          AddNotification().addNotification(
                            topics: "/topics/POST_EN",
                            body: "$username added a new post",
                            title: "FayTour Community",
                            navigation: "POST",
                          );
                          AddNotification().addNotification(
                            topics: "/topics/POST_AR",
                            body: "أضاف $username منشوراً جديداً",
                            title: "مجتمع فايتور",
                            navigation: "POST",
                          );

                          // sharedPreferences!.getString("Language") == "AR"
                          //     ? await FirebaseMessaging.instance
                          //         .subscribeToTopic("POST_AR")
                          //     : await FirebaseMessaging.instance
                          //         .subscribeToTopic("POST_EN");
                        }
                      } else if (state.addPostState == RequestState.error ||
                          state.updatePostState == RequestState.error) {
                        Navigator.pop(context);
                        SnackBarMessage().showErrorSnackBar(
                            message: "problem happened try again",
                            context: context);
                      }
                    },
                    builder: (context, state) {
                      return TextButton(
                        child: Center(
                          child: Text(
                            widget.type == 'add'
                                ? AppLocalizations.of(context)!
                                    .translate("Post")
                                : AppLocalizations.of(context)!
                                    .translate("Update"),
                            style: TextStyle(
                                fontFamily:
                                    sharedPreferences!.getString("Language") ==
                                            "AR"
                                        ? "Mag"
                                        : "rye",
                                fontSize: (16 / 360) *
                                    MediaQuery.of(context).size.width, //16,
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                          ),
                        ),
                        onPressed: () async {
                          // ------------ Add Post ------------
                          // AddNotification().addNotification(
                          //   topics: "/topics/POST_EN",
                          //   body: "$username added a new post",
                          //   title: "FayTour Community",
                          //   navigation: "POST",
                          // );
                          // AddNotification().addNotification(
                          //   topics: "/topics/POST_AR",
                          //   body: "أضاف $username منشوراً جديداً",
                          //   title: "مجتمع فايتور",
                          //   navigation: "POST",
                          // );

                          // if (widget.type == 'add') {
                          //   await FirebaseMessaging.instance
                          //       .unsubscribeFromTopic("POST_EN");
                          //   await FirebaseMessaging.instance
                          //       .unsubscribeFromTopic("POST_AR");
                          // }
                          if (widget.type != 'add' &&
                              _textEditingController.text == widget.data.body &&
                              !changeInImages) {
                            if (_textEditingController.text
                                        .replaceAll("\n", "")
                                        .replaceAll(" ", "") ==
                                    "" &&
                                _imageList.isEmpty &&
                                _providedimageList.isEmpty) {
                              upload = false;
                            }
                          } else {
                            upload = true;
                          }

                          if (widget.type == "add" &&
                                  (_textEditingController.text
                                              .replaceAll("\n", "")
                                              .replaceAll(" ", "") !=
                                          "" ||
                                      _imageList.isNotEmpty) ||
                              (widget.type != "add" && upload)) {
                            List<String> imagesPath = [];
                            for (int i = 0; i < _imageList.length; i++) {
                              imagesPath.add(_imageList[i].path);
                            }

                            String body = "";
                            body = _textEditingController.text;

                            PostData postData = PostData(
                                body: body,
                                images: imagesPath,
                                // createdAt: DateFormat('yyyy-MM-dd HH:mm:ss')
                                //     .format(DateTime.now()));
                                createdAt: formatDate(DateTime.now(), [
                                  yyyy,
                                  '-',
                                  mm,
                                  '-',
                                  dd,
                                  ' ',
                                  HH,
                                  ':',
                                  nn,
                                  ':',
                                  ss
                                ]));
                            if (widget.type == "add") {
                              BlocProvider.of<PostBloc>(context)
                                  .add(AddPostEvent(postData: postData));
                            } else if (widget.type == "edit") {
                              String removeString = "-1";
                              if (_removedProvidedimageIndexList.isNotEmpty) {
                                removeString = "";
                                for (int i = 0;
                                    i < _removedProvidedimageIndexList.length;
                                    i++) {
                                  if (i ==
                                      _removedProvidedimageIndexList.length -
                                          1) {
                                    removeString +=
                                        "${_removedProvidedimageIndexList[i]}";
                                  } else {
                                    removeString +=
                                        "${_removedProvidedimageIndexList[i]},";
                                  }
                                }
                              }
                              BlocProvider.of<PostBloc>(context)
                                  .add(UpdatePostEvent(
                                body: body,
                                images: imagesPath,
                                posId: widget.data.id.toString(),
                                index: removeString,
                              ));
                            }

                            // print("---------------------------");
                            // print(imagesPath);
                            // _textEditingController.clear();
                            // setState(() {
                            //   _imageList = [];
                            // });

                            if (state.addPostState == RequestState.loading ||
                                state.updatePostState == RequestState.loading) {
                              //print("Post Loding");

                              showDialog(
                                context: context,
                                barrierDismissible: false,
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
                            }
                          }
                        },
                      );
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
                  // user image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: (50 / 360) *
                                MediaQuery.of(context).size.width, //50,
                            height: (50/360)*MediaQuery.of(context).size.width,//50,
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
                            style: TextStyle(
                              fontFamily: "aBeeZee",
                              fontWeight: FontWeight.bold,
                              fontSize: (18 / 360) *
                                  MediaQuery.of(context).size.width, //18,
                            ),
                          ),
                        ],
                      ),
                      // input images post
                      IconButton(
                        color: Colors.green,
                        iconSize: (35 / 360) *
                            MediaQuery.of(context).size.width, //35,
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
                                        title: Text(
                                            AppLocalizations.of(context)!
                                                .translate('Photo Library')),
                                        onTap: () async {
                                          pickedFiles = await ImagePicker()
                                              .pickMultiImage();
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.photo_camera),
                                        title: Text(
                                            AppLocalizations.of(context)!
                                                .translate('Camera')),
                                        onTap: () async {
                                          final pickedFile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera);
                                          Navigator.pop(context, pickedFile);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );

                            // _pickedimageList = await MultiImagePicker.pickImages(
                            // maxImages: 10,
                            // enableCamera: true,
                            // );

                            setState(() {
                              if (pickedFile != null) {
                                _imageList.add(File(pickedFile.path));
                                changeInImages = true;
                              } else if (pickedFiles.isNotEmpty) {
                                for (final file in pickedFiles) {
                                  _imageList.add(File(file.path));
                                }
                                pickedFiles = [];
                                changeInImages = true;
                              } else {
                                //print('No image selected.');
                              }
                            });
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
                        textDirection: theTextDirection,
                        style: TextStyle(
                          fontSize: (25 / 360) *
                              MediaQuery.of(context).size.width, //25
                        ),
                        // initialValue: widget.data.body.toString(),
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!
                              .translate("Write your post now!"),
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(30)),

                          border: InputBorder.none,
                        ),
                        maxLines: null,
                        onChanged: (value) {

                          if (value != "" && isEnglish(value) && theTextDirection == TextDirection.rtl)
                          {
                            setState(() {theTextDirection = TextDirection.ltr;});
                          }
                          else if (value != "" && !isEnglish(value) && theTextDirection == TextDirection.ltr)
                          {
                            setState(() {theTextDirection = TextDirection.rtl;});
                          }

                          if ((_text == "" && value != "") || (_text != "" && value == "")) {
                            setState(() {});
                          }

                          if (widget.type != 'add') {
                            if ((_text == widget.data.body && value != widget.data.body) || value == widget.data.body) 
                            {
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

                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.type == 'add'
                          ? _imageList.length
                          : _calculateMaxItemCount(),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            widget.type != 'add'
                                ? index < _providedimageList.length
                                    ? _buildImageContainer(
                                        _providedimageList[index],
                                        File(""),
                                        index)
                                    : Container()
                                : Container(),
                            if (index < _imageList.length)
                              _buildImageContainer(
                                  "", _imageList[index], index),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 7),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  int _calculateMaxItemCount() {
    return max(_providedimageList.length, _imageList.length);
  }

  Widget _buildImageContainer(String imageProvider, File image, int pos) {
    return Container(
      height: (120 / 772) * MediaQuery.of(context).size.height, //120,
      margin: const EdgeInsets.symmetric(horizontal: 3),
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
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imageProvider == ""
                  ? Image.file(
                      image,
                      fit: BoxFit.cover,
                      width: (100 / 360) *
                          MediaQuery.of(context).size.width, //100,
                    )
                  : Image.network(
                      imageProvider,
                      fit: BoxFit.cover,
                      width: (100 / 360) *
                          MediaQuery.of(context).size.width, //100,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppStrings.error1Gif,
                          fit: BoxFit.cover,
                          width: (100 / 360) *
                              MediaQuery.of(context).size.width, //100,
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress != null) {
                          return Image.asset(
                            AppStrings.loading2Gif,
                            fit: BoxFit.cover,
                            width: (100 / 360) *
                                MediaQuery.of(context).size.width, //100,
                          );
                        }
                        return child;
                      },
                    ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    if (imageProvider == "") {
                      _imageList.removeAt(pos);
                      changeInImages = true;
                    } else {
                      _providedimageList.removeAt(pos);
                      _removedProvidedimageIndexList.add(pos);
                      changeInImages = true;
                    }
                  });
                },
                child: Icon(
                  Icons.cancel,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
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
