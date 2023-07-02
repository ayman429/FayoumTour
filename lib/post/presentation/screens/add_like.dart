import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/snackbar_message.dart';
import '../../../home/my_flutter_app_icons.dart';
import '../../domain/entities/like.dart';
import '../controller/bloc/post_bloc.dart';

class AddLike extends StatelessWidget {
  int postId;
  AddLike({
    Key? key,
    required this.postId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        if (state.addLikeState == RequestState.loaded) {
          // print("Loded");
        } else if (state.addLikeState == RequestState.loading) {
          print(" state.like");
        } else if (state.addLikeState == RequestState.error) {
          SnackBarMessage().showErrorSnackBar(
              message: state.addLikeMessage, context: context);
        }
      },
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            print("like");
            print(state.like);
            Like like = Like(
                like: state.like == "0" ? 1 : 0,
                postId: postId,
                user: int.parse(sharedPreferences!.getString("USERID") ?? "0"));
            print("likeN");
            print(like.like);
            BlocProvider.of<PostBloc>(context).add(AddLikeEvent(like: like));
          },
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: Row(
            children: [
              state.like == "0"
                  ? const Icon(
                      MyFlutterApp.like3,
                      color: Colors.grey,
                    )
                  : const Icon(
                      MyFlutterApp.like2,
                      color: Colors.blue,
                    ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                "Like",
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
        );
      },
    );

    ;
  }
}
