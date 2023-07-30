import 'package:fayoumtour/post/domain/entities/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/constance/strings_manager.dart';
import '../controller/bloc/post_bloc.dart';

class CommentList extends StatelessWidget {
  List<Comment> data;
  CommentList({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
                    itemCount: data.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: Column(children: [
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: SizedBox(
                              width: 40,
                              height: 40,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: data[index].createdBy!.image != ""
                                      ? Image.network(
                                          data[index].createdBy!.image,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              AppStrings.error1Gif,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                          loadingBuilder:
                                              (context, child, loadingProgress) {
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
                            title: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.tertiaryContainer,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            data[index].createdBy!.userName ?? "",
                                            style: const TextStyle(
                                              fontFamily: "readPro",
                                                fontWeight: FontWeight.bold
                                                ),
                                          ),
                                        ),
                                        (data[index].createdBy!.id ==
                                                    int.parse(sharedPreferences!
                                                            .getString("USERID") ??
                                                        "0")) ||
                                                (int.parse(sharedPreferences!
                                                            .getString("USERID") ??
                                                        "0") ==
                                                    5)
                                            ? BlocBuilder<PostBloc, PostState>(
                                                builder: (context, state) {
                                                  return InkWell(
                                                    onTap: () {
                                                      BlocProvider.of<PostBloc>(context)
                                                          .add(DeleteCommentEvent(
                                                              commentId: data[index].id!));
                                                    },
                                                    child: const Icon(Icons.cancel),
                                                  );
                                                },
                                              )
                                            : InkWell(
                                                onTap: () {},
                                                child: const Icon(
                                                  Icons.lock,
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      data[index].comment,
                                      style: const TextStyle(fontFamily: "ibmP"),
                                    ),
                                  ],
                                )),
                          ),
                          data.length-1 == index ? const SizedBox(height: 85,) : Container(),
                        ]),
                      );
                    });
  }
}
