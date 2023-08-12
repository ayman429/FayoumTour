import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/notification/add notification.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/snackbar_message.dart';
import '../../../home/my_flutter_app_icons.dart';
import '../../domain/entities/created_by.dart';
import '../../domain/entities/like.dart';
import '../controller/bloc/post_bloc.dart';

class AddLike extends StatelessWidget {
  final int postId;
  final int like_value;
  CreatedBy? createdBy;
  AddLike({
    Key? key,
    required this.postId,
    required this.like_value,
    this.createdBy,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PostBloc>(),
      child: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state.addLikeState == RequestState.loaded) {
            // print("Loded");
            // print(likeMap[postId]);
          } else if (state.addLikeState == RequestState.loading) {
            //print("loding");
            // print(likeMap[postId]);
          } else if (state.addLikeState == RequestState.error) {
            SnackBarMessage().showErrorSnackBar(
                message: state.addLikeMessage, context: context);
          }
        },
        builder: (context, state) {
          return TextButton(
            onPressed: () {
              if (likeMap[postId] == 0) {
                AddNotification().addNotification(
                  topics: "/topics/LIKE_EN${createdBy!.id.toString()}",
                  body:
                      "${sharedPreferences!.getString("username")} reacted to your post",
                  title: "FayTour Community",
                  navigation: "LIKE",
                );
                AddNotification().addNotification(
                  topics: "/topics/LIKE_AR${createdBy!.id.toString()}",
                  body:
                      "تفاعل علي منشور لك ${sharedPreferences!.getString("username")}",
                  title: "مجتمع فايتور",
                  navigation: "LIKE",
                );
              }
              likeMap[postId] == 0
                  ? AudioPlayer().play(AssetSource('images/like.mp3'))
                  : null;
              Like like = Like(
                  like: like_value == 0 ? 1 : 0,
                  postId: postId,
                  user:
                      int.parse(sharedPreferences!.getString("USERID") ?? "0"));
              // print("likeN");
              // print(like.like);
              BlocProvider.of<PostBloc>(context).add(AddLikeEvent(like: like));
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            child: Row(
              children: [
                likeMap[postId] == 1
                    ? const Icon(
                        MyFlutterApp.like3,
                        color: Colors.blue,
                      )
                    : const Icon(
                        MyFlutterApp.like3,
                        color: Colors.grey,
                      ),
                const SizedBox(
                  width: 5,
                ),
                likeMap[postId] == 1
                    ? Text(
                        AppLocalizations.of(context)!.translate("Liked"),
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                      )
                    : Text(
                        AppLocalizations.of(context)!.translate("Like"),
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
