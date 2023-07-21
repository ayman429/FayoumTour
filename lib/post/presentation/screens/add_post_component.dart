import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
  bool upload = true;
  //bool changeInImages = false;
  final List<File> _imageList = [];
  //final List<String> _ProvidedimageList = [];
  //final List<int> _RemovedProvidedimageIndexList = [];
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

      // for(int i = 0; i < widget.data.imagesP.length; i++)
      // {
      //   _ProvidedimageList.add(widget.data.imagesP[i].imageT);
      // }
      
    }
    updateUIWithImagePath();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(widget.type == 'add' ? "Create Post" : "Edit Post"),
            actions: [
              Opacity(
                opacity: _textEditingController.text == "" && _imageList.isEmpty
                    ? 0.5
                    : widget.type == 'add'
                        ? 1
                        : _textEditingController.text == widget.data.body /*&& !changeInImages*/
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
                  child: BlocConsumer<PostBloc, PostState>(
                    listener: (context, state) {
                      if (state.addPostState == RequestState.loaded ||
                          state.updatePostState == RequestState.loaded) {
                        print("Post Loded");
                        BlocProvider.of<PostBloc>(context).add(GetPostEvent());
                        print("Post Loded");
                        Navigator.pop(context);
                        Navigator.pop(context);
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
                            widget.type == 'add' ? 'Post' : "Update",
                            style: TextStyle(
                                fontFamily: "rye",
                                fontSize: 17,
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                          ),
                        ),
                        onPressed: () async {
                          if (widget.type != 'add' && _textEditingController.text == widget.data.body /*&& !changeInImages*/) {
                            upload = false;
                          } else {
                            upload = true;
                          }
                          

                          if (upload) {
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

                              // print("---------------------------");
                              // print(imagesPath);
                              // _textEditingController.clear();
                              // setState(() {
                              //   _imageList = [];
                              // });

                              if (state.addPostState == RequestState.loading ||
                                  state.updatePostState ==
                                      RequestState.loading) {
                                print("Post Loding");

                                showDialog(
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
                              }
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
                            style: const TextStyle(
                              fontFamily: "aBeeZee",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      // input images post
                      widget.type == "add" ? IconButton(
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
                                          final pickedFile = await ImagePicker()
                                              .pickImage(
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
                                              await ImagePicker().pickImage(
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
                                //changeInImages = true;
                              } else {
                                print('No image selected.');
                              }
                            });
                          }
                        },
                      )
                      : Container(),
                    
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

                  SizedBox(
  height: 120,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: /*widget.type == 'add' ?*/ _imageList.length /*: _calculateMaxItemCount()*/,
    itemBuilder: (context, index) {
      return Row(
        children: [
          /*widget.type != 'add' ? index < _ProvidedimageList.length ?
            _buildImageContainer(_ProvidedimageList[index],File(""),index): Container(): Container(),
          if (index < _imageList.length)*/
            _buildImageContainer("",_imageList[index],index),
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

//   int _calculateMaxItemCount() {
//   return max(_ProvidedimageList.length, _imageList.length);
// }

Widget _buildImageContainer(String imageProvider, File image, int pos) {
  return Container(
    height: 120,
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
                              ).createShader(Rect.fromLTRB(
                                  0, 0, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstIn,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: imageProvider == "" ? Image.file(
                                image,
                                fit: BoxFit.cover,
                                width: 100,
                              )
                              : Image.network(
                                  imageProvider,
                                  fit: BoxFit.cover,
                                  width: 100,
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if(imageProvider == "")
                  {
                    _imageList.removeAt(pos);
                    //changeInImages = true;
                  }
                  else
                  {
                    // _ProvidedimageList.removeAt(pos);
                    // _RemovedProvidedimageIndexList.add(pos);
                    // changeInImages = true;
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
