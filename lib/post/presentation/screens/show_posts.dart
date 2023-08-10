import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/constance/strings_manager.dart';
import '../../../core/utils/enums.dart';
import '../../../home/image_list.dart';
import '../../../home/my_flutter_app_icons.dart';
import '../controller/bloc/post_bloc.dart';
import 'AR_EN_Post.dart';
import 'add_like.dart';
import 'add_post_component.dart';
import 'comment_screen.dart';
import 'post_time.dart';

class ShowPosts extends StatelessWidget {
  const ShowPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listenWhen: (previous, current) =>
          previous.postState != current.postState,
      listener: (context, state) {
        for (var element in state.post) {
          likeMap
              .addAll({int.parse(element.id ?? "0"): element.like_value ?? 0});
        }
      },
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          BlocProvider.of<PostBloc>(context).add(GetPostEvent());

          switch (state.postState) {
            case RequestState.loading:
              //print("loading");
              return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()));
            case RequestState.loaded:
              //print("loaded");
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.post.length,
                itemBuilder: (context, index) {
                  final words = state.post[index].body.split("\n");

                  return Container(
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
                        const SizedBox(height: 16),
                        Container(
                          margin:
                              sharedPreferences!.getString("Language") == "AR"
                                  ? const EdgeInsets.only(right: 5)
                                  : const EdgeInsets.only(left: 5),
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
                                            ? CachedNetworkImage(imageUrl: state.post[index].createdBy!.image,
                                            fadeInDuration: const Duration(milliseconds: 350),
                  fadeOutDuration: const Duration(milliseconds: 350),
                                    fit: BoxFit.cover,
                placeholder: (context, url) {
                    return Image.asset(AppStrings.profileImage,fit: BoxFit.cover,);
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(AppStrings.error1Gif,fit: BoxFit.cover,);
                  },
                                            )
                                            // Image.network(
                                            //     state.post[index].createdBy!.image,
                                            //     fit: BoxFit.cover,
                                            //     errorBuilder: (context, error,
                                            //         stackTrace) {
                                            //       return Image.asset(
                                            //         AppStrings.error1Gif,
                                            //         fit: BoxFit.cover,
                                            //       );
                                            //     },
                                            //     loadingBuilder: (context, child,
                                            //         loadingProgress) {
                                            //       if (loadingProgress != null) {
                                            //         return Image.asset(
                                            //           AppStrings.loading1Gif,
                                            //           fit: BoxFit.cover,
                                            //         );
                                            //       }
                                            //       return child;
                                            //     },
                                            //   )
                                            : Image.asset(
                                                AppStrings.profileImage,
                                                fit: BoxFit.cover,
                                              )),
                                  
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${state.post[index].createdBy!.userName}',
                                          style: const TextStyle(
                                            fontFamily: "readPro",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        state.post[index].createdBy!.mark ==
                                                true
                                            ? Image.asset(
                                                'assets/icons/mark.png',
                                                width: 15,
                                                height: 15,
                                              )
                                            : Container(),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      PostTime(
                                          "${state.post[index].createdAt}"),
                                      // "${state.post[index].createdAt}",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontFamily: "readPro"),
                                    ),
                                  ],
                                ),
                              ),
                              (int.parse(sharedPreferences!
                                                  .getString("USERID") ??
                                              "0") ==
                                          state.post[index].createdBy!.id) ||
                                      (int.parse(sharedPreferences!
                                                  .getString("USERID") ??
                                              "0") ==
                                          5)
                                  ? Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddPostComponent(
                                                            type: "edit",
                                                            data: state
                                                                .post[index],
                                                          )));
                                              // BlocProvider.of<PostBloc>(context)
                                              //     .add(DeletePostEvent(
                                              //         postId:
                                              //             state.post[index].id!));
                                              // BlocProvider.of<PostBloc>(context)
                                              //     .add(GetPostEvent());
                                            },
                                            icon: const Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () {
                                              BlocProvider.of<PostBloc>(context)
                                                  .add(DeletePostEvent(
                                                      postId: state
                                                          .post[index].id!));
                                              // BlocProvider.of<PostBloc>(context)
                                              //     .add(GetPostEvent());
                                              // context.read<PostBloc>().add(
                                              //     DeletePostEvent(
                                              //         postId:
                                              //             state.post[index].id!));
                                            },
                                            icon: const Icon(Icons.cancel)),
                                      ],
                                    )
                                  : Container()
                            ],
                          ),
                        ),

                        state.post[index].body == ""
                            ? const SizedBox(
                                height: 10,
                              )
                            : Column(
                                children: [
                                  for (final word in words)
                                    isEnglish(word.replaceAll(" ", ""))
                                        ? Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 12),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                word,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: "ibmP"
                                                    //fontWeight: FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 12),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                word,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: "ibmP"
                                                    //fontWeight: FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                          ),
                                ],
                              ),
                        // isEnglish(state.post[index].body[0])
                        //     ? Container(
                        //         margin: const EdgeInsets.symmetric(
                        //             horizontal: 8, vertical: 12),
                        //         child: Align(
                        //           alignment: Alignment.centerLeft,
                        //           child: Text(
                        //             state.post[index].body,
                        //             style: const TextStyle(
                        //                 fontSize: 20, fontFamily: "ibmP"
                        //                 //fontWeight: FontWeight.bold,
                        //                 ),
                        //           ),
                        //         ),
                        //       )
                        //     : Container(
                        //         margin: const EdgeInsets.symmetric(
                        //             horizontal: 8, vertical: 12),
                        //         child: Align(
                        //           alignment: Alignment.centerRight,
                        //           child: Text(
                        //             state.post[index].body,
                        //             style: const TextStyle(
                        //                 fontSize: 20, fontFamily: "ibmP"
                        //                 //fontWeight: FontWeight.bold,
                        //                 ),
                        //           ),
                        //         ),
                        //       ),

                        state.post[index].imagesP.isNotEmpty
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.47,
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: state
                                              .post[index].imagesP.length ==
                                          1
                                      ? SliverQuiltedGridDelegate(
                                          crossAxisCount: 1,
                                          pattern: [
                                              const QuiltedGridTile(1, 1)
                                            ])
                                      : state.post[index].imagesP.length == 2
                                          ? SliverQuiltedGridDelegate(
                                              crossAxisCount: 2,
                                              pattern: [
                                                const QuiltedGridTile(2, 1),
                                                const QuiltedGridTile(2, 1)
                                              ],
                                              mainAxisSpacing: 3,
                                              crossAxisSpacing: 3)
                                          : state.post[index].imagesP.length ==
                                                  3
                                              ? SliverQuiltedGridDelegate(
                                                  crossAxisCount: 2,
                                                  pattern: [
                                                    const QuiltedGridTile(2, 1),
                                                    const QuiltedGridTile(1, 1),
                                                    const QuiltedGridTile(1, 1)
                                                  ],
                                                  mainAxisSpacing: 3,
                                                  crossAxisSpacing: 3)
                                              : SliverQuiltedGridDelegate(
                                                  crossAxisCount: 2,
                                                  pattern: [
                                                    const QuiltedGridTile(1, 1),
                                                    const QuiltedGridTile(1, 1)
                                                  ],
                                                  mainAxisSpacing: 3,
                                                  crossAxisSpacing: 3),
                                  itemCount: state.post[index].imagesP.length,
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
                                              // Image.asset(
                                              //     "assets/images/photoLoading.jpeg",
                                              //     fit: BoxFit.cover),
                                              Opacity(
                                                opacity: state.post[index]
                                                            .imagesP.length >
                                                        4
                                                    ? 0.4
                                                    : 1.0,
                                                child:
                                                CachedNetworkImage(imageUrl: state.post[index].imagesP[x].imageT,
                                                fadeInDuration: const Duration(milliseconds: 350),
                  fadeOutDuration: const Duration(milliseconds: 350),
                                    fit: BoxFit.cover,
                placeholder: (context, url) {
                    return Image.asset("assets/images/photoLoading.jpeg",fit: BoxFit.cover,);
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(AppStrings.error1Gif,fit: BoxFit.cover,);
                  },
                                                )
                                                // Image.network(
                                                //   state.post[index].imagesP[x].imageT,
                                                //   fit: BoxFit.cover,
                                                //   errorBuilder: (context, error,
                                                //       stackTrace) {
                                                //     return Image.asset(
                                                //       AppStrings.error1Gif,
                                                //       fit: BoxFit.cover,
                                                //     );
                                                //   },
                                                //   loadingBuilder: (context,
                                                //       child, loadingProgress) {
                                                //     if (loadingProgress !=
                                                //         null) {
                                                //       return Image.asset(
                                                //         AppStrings.loading2Gif,
                                                //         fit: BoxFit.cover,
                                                //       );
                                                //     }
                                                //     return child;
                                                //   },
                                                // ),
                                              ),
                                              state.post[index].imagesP.length >
                                                      4
                                                  ? Center(
                                                      child: Text(
                                                        "+${state.post[index].imagesP.length - 4}",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onPrimary,
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
                                          child:
                                          CachedNetworkImage(imageUrl: state.post[index].imagesP[x].imageT,
                                          fadeInDuration: const Duration(milliseconds: 350),
                  fadeOutDuration: const Duration(milliseconds: 350),
                                    fit: BoxFit.cover,
                placeholder: (context, url) {
                    return Image.asset("assets/images/photoLoading.jpeg",fit: BoxFit.cover,);
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(AppStrings.error1Gif,fit: BoxFit.cover,);
                  },
                                          )
                                          // Image.network(
                                          //       state.post[index].imagesP[x].imageT,
                                          //       fit: BoxFit.cover,
                                          //       errorBuilder: (context, error,
                                          //           stackTrace) {
                                          //         return Image.asset(
                                          //           AppStrings.error1Gif,
                                          //           fit: BoxFit.cover,
                                          //         );
                                          //       },
                                          //       loadingBuilder: (context, child,
                                          //           loadingProgress) {
                                          //         if (loadingProgress != null) {
                                          //           return Image.asset(
                                          //             AppStrings.loading2Gif,
                                          //             fit: BoxFit.cover,
                                          //           );
                                          //         }
                                          //         return child;
                                          //       },
                                          //     ),
                                        );
                                      }
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              )
                            : const SizedBox.shrink(),

                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  state.post[index].like_numbers != "0"
                                      ? Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 3.5),
                                              child: Icon(MyFlutterApp.like3,
                                                  color: Colors.blue),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "${state.post[index].like_numbers}",
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontFamily: "readPro"),
                                            )
                                          ],
                                        )
                                      : Container(),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CommentScreen(
                                                        postId: int.parse(state
                                                                .post[index]
                                                                .id ??
                                                            "0"))));
                                      },
                                      child:
                                          state.post[index].comment_numbers !=
                                                  "0"
                                              ? Text(
                                                  "${state.post[index].comment_numbers} ${AppLocalizations.of(context)!.translate("Comments")}",
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                      fontFamily: "readPro"),
                                                )
                                              : Container()),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                color: Color.fromARGB(255, 122, 122, 122),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // like_value
                                  AddLike(
                                      like_value:
                                          state.post[index].like_value ?? 0,
                                      postId: int.parse(
                                          state.post[index].id ?? "0")),
                                  // GetLike(
                                  //     postId:
                                  //         int.parse(state.post[index].id ?? "0")),
                                  TextButton(
                                      onPressed: () {
                                        //print(state.post[index].id);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CommentScreen(
                                                      postId: int.parse(state
                                                              .post[index].id ??
                                                          "0")),
                                            ));
                                      },
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.insert_comment_outlined,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              AppLocalizations.of(context)!
                                                  .translate("Comment"),
                                              style: const TextStyle(
                                                  color: Colors.grey))
                                        ],
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),

                        //const SizedBox(height: 8,),
                      ],
                    ),
                  );
                },
              );

            case RequestState.error:
              //print("error-------------000>");
              //print(state.postMessage);
              return const Center(
                child: Image(
                  image: AssetImage('assets/images/noWifi.gif'),
                ),
              );
          }
        },
      ),
    );
  }
}
