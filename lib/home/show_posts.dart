import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/services/services_locator.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';
import '../core/utils/enums.dart';
import '../post/presentation/controller/bloc/post_bloc.dart';
import 'image_list.dart';

class ShowPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        BlocProvider.of<PostBloc>(context).add(GetPostEvent());
        print("----------------------------");
        print(state.postState);
        switch (state.postState) {
          case RequestState.loading:
            return const SizedBox(
                height: 200, child: Center(child: CircularProgressIndicator()));
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
                                  borderRadius: BorderRadius.circular(100),
                                  child: (state.post[index].createdBy!.image !=
                                          "")
                                      ? Image.network(
                                          state.post[index].createdBy!.image,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              AppStrings.error1Gif,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress != null) {
                                              return Image.asset(
                                                AppStrings.loading1Gif,
                                                fit: BoxFit.cover,
                                              );
                                            }
                                            return child;
                                          },
                                        )
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
                            (int.parse(sharedPreferences!.getString("USERID") ??
                                        "0") ==
                                    state.post[index].createdBy!.id)
                                ? IconButton(
                                    onPressed: () {
                                      // String postId = "0";
                                      // postId=state.post[index].id!;
                                      BlocProvider.of<PostBloc>(context).add(
                                          DeletePostEvent(
                                              postId: state.post[index].id!));
                                      BlocProvider.of<PostBloc>(context)
                                          .add(GetPostEvent());

                                      // DocumentReference documentReference =
                                      //     FirebaseFirestore.instance
                                      //         .collection('Posts')
                                      //         .doc(snapshot
                                      //             .data?.docs[index].id);
                                      // documentReference.delete();
                                    },
                                    icon: const Icon(Icons.cancel))
                                : Container()
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
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: state
                                            .post[index].imagesP.length ==
                                        1
                                    ? SliverQuiltedGridDelegate(
                                        crossAxisCount: 1,
                                        pattern: [const QuiltedGridTile(1, 1)])
                                    : state.post[index].imagesP.length == 2
                                        ? SliverQuiltedGridDelegate(
                                            crossAxisCount: 2,
                                            pattern: [
                                              const QuiltedGridTile(2, 1),
                                              const QuiltedGridTile(2, 1)
                                            ],
                                            mainAxisSpacing: 3,
                                            crossAxisSpacing: 3)
                                        : state.post[index].imagesP.length == 3
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
                                                builder: (context) => ImageList(
                                                    imageList: state
                                                        .post[index].imagesP,
                                                    index: x))),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Opacity(
                                              opacity: state.post[index].imagesP
                                                          .length >
                                                      4
                                                  ? 0.6
                                                  : 1.0,
                                              child: ClipRRect(
                                                //borderRadius:BorderRadius.circular(10),
                                                child: Image.network(
                                                  state.post[index]
                                                      .imagesP[index].imageT,
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
                                                        AppStrings.loading2Gif,
                                                        fit: BoxFit.cover,
                                                      );
                                                    }
                                                    return child;
                                                  },
                                                ),
                                              ),
                                            ),
                                            state.post[index].imagesP.length > 4
                                                ? Center(
                                                    child: Text(
                                                      "+${state.post[index].imagesP.length - 4}",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 40,
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                builder: (context) => ImageList(
                                                    imageList: state
                                                        .post[index].imagesP,
                                                    index: x))),
                                        child: ClipRRect(
                                          //borderRadius:BorderRadius.circular(10),
                                          child: Image.network(
                                            state.post[index].imagesP[x].imageT,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                AppStrings.error1Gif,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress != null) {
                                                return Image.asset(
                                                  AppStrings.loading2Gif,
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
    );
  }
}
