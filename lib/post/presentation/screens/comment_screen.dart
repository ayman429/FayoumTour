import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/notification/add notification.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/constance/strings_manager.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/snackbar_message.dart';
import '../../domain/entities/comment.dart';
import '../../domain/entities/created_by.dart';
import '../controller/bloc/post_bloc.dart';
import 'get_comment.dart';

Map<int, dynamic> commentIds = {};

class CommentScreen extends StatefulWidget {
  final int postId;
  final int createdBy_id;
  CommentScreen({
    Key? key,
    required this.postId,
    required this.createdBy_id,
  }) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  String _text = "";

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PostBloc>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(AppLocalizations.of(context)!.translate("Comments"),
              style: sharedPreferences!.getString("Language") == "AR"
                  ? const TextStyle(
                      fontFamily: "galaxy",
                      fontWeight: FontWeight.bold,
                      fontSize: 28)
                  : const TextStyle(
                      fontFamily: AppStrings.fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
          centerTitle: true,
        ),
        floatingActionButton: Container(
          margin: sharedPreferences!.getString("Language") == "AR"
              ? const EdgeInsets.only(right: 35)
              : const EdgeInsets.only(left: 35),
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.tertiaryContainer,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              hintText:
                  AppLocalizations.of(context)!.translate("Write a comment..."),
              hintStyle: const TextStyle(color: Colors.grey),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              suffixIcon: BlocConsumer<PostBloc, PostState>(
                listener: (context, state) {
                  if (state.addCommentState == RequestState.loaded ||
                      state.updateCommentState == RequestState.loaded) {
                    // BlocProvider.of<PostBloc>(context)
                    //     .add(GetCommentEvent(postId: widget.postId));
                    //print("Loded");
                    // Navigator.pop(context);
                    _textEditingController.clear();
                  } else if (state.addCommentState == RequestState.loading ||
                      state.updateCommentState == RequestState.loading) {
                    //print("Comment Loding");

                    /// loading
                    // return Text("Processing");
                    // Dialog(
                    //   child: Text("loading"),
                    // );
                  } else if (state.addCommentState == RequestState.error ||
                      state.updateCommentState == RequestState.error) {
                    SnackBarMessage().showErrorSnackBar(
                        message: state.addCommentMessage, context: context);
                  }
                },
                builder: (context, state) {
                  return IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _text == ""
                        ? null
                        : () {
                            //createdBy
                            // ------------ Add Comment ------------
                            print("-----------------");
                            print(widget.createdBy_id.toString());
                            AddNotification().addNotification(
                              topics:
                                  "/topics/COMMENT_EN${widget.createdBy_id.toString()}",
                              body:
                                  "${sharedPreferences!.getString("username")} adds a comment to your post",
                              title: "FayTour Community",
                              navigation: "COMMENT",
                              id: widget.postId,
                              createdBy_id: widget.createdBy_id,
                            );
                            AddNotification().addNotification(
                              topics:
                                  "/topics/COMMENT_AR${widget.createdBy_id.toString()}",
                              body:
                                  "اضاف تعليق علي منشور لك ${sharedPreferences!.getString("username")}",
                              title: "مجتمع فايتور",
                              navigation: "COMMENT",
                              id: widget.postId,
                              createdBy_id: widget.createdBy_id,
                            );

                            for (var element in commentIds[widget.postId]) {
                              AddNotification().addNotification(
                                topics:
                                    "/topics/COMMENT_EN${element.toString()}",
                                body:
                                    "${sharedPreferences!.getString("username")} adds a new comment to a post you are following",
                                title: "FayTour Community",
                                navigation: "COMMENT",
                                id: widget.postId,
                                createdBy_id: widget.createdBy_id,
                              );
                              AddNotification().addNotification(
                                topics:
                                    "/topics/COMMENT_AR${element.toString()}",
                                body:
                                    "اضاف تعليق جديد على المنشور الذي تتابعه ${sharedPreferences!.getString("username")}",
                                title: "مجتمع فايتور",
                                navigation: "COMMENT",
                                id: widget.postId,
                                createdBy_id: widget.createdBy_id,
                              );
                            }

                            String? id = sharedPreferences!.getString("USERID");
                            int userId = int.parse(id!);
                            Comment comment = Comment(
                                user: userId,
                                post: widget.postId,
                                comment: _text);
                            BlocProvider.of<PostBloc>(context)
                                .add(AddCommentEvent(comment: comment));
                          },
                  );
                },
              ),
              suffixIconColor: _textEditingController.text == ""
                  ? Colors.grey
                  : Colors.green,
            ),
            maxLines: 5,
            minLines: 1,
            onChanged: (value) {
              if ((_text == "" && value != "") ||
                  (_text != "" && value == "")) {}

              _text = value;
              setState(() {});
            },
          ),
        ),
        body: GetComment(postId: widget.postId),
      ),
    );
  }
}
