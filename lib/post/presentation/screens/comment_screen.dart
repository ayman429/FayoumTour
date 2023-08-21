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
import '../controller/bloc/post_bloc.dart';
import 'get_comment.dart';

Map<int, dynamic> commentIds = {};

class CommentScreen extends StatefulWidget {
  final int postId;
  final int createdBy_id;
  const CommentScreen({
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
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: (16 / 360) * MediaQuery.of(context).size.width,
              ),
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
                    AddNotification().addNotification(
                      topics:
                          "/topics/COMMENT_EN${widget.createdBy_id.toString()}",
                      body:
                          "${sharedPreferences!.getString("username")} added a comment to your post",
                      title: "FayTour Community",
                      navigation: "COMMENT",
                      id: widget.postId,
                      createdBy_id: widget.createdBy_id,
                    );
                    AddNotification().addNotification(
                      topics:
                          "/topics/COMMENT_AR${widget.createdBy_id.toString()}",
                      body:
                          "أضاف ${sharedPreferences!.getString("username")} تعليقاً على منشور لك",
                      title: "مجتمع فايتور",
                      navigation: "COMMENT",
                      id: widget.postId,
                      createdBy_id: widget.createdBy_id,
                    );

                    for (var element in commentIds[widget.postId]) {
                      AddNotification().addNotification(
                        topics: "/topics/COMMENT_EN${element.toString()}",
                        body:
                            "${sharedPreferences!.getString("username")} added a new comment to a post you are following it",
                        title: "FayTour Community",
                        navigation: "COMMENT",
                        id: widget.postId,
                        createdBy_id: widget.createdBy_id,
                      );
                      AddNotification().addNotification(
                        topics: "/topics/COMMENT_AR${element.toString()}",
                        body:
                            "أضاف ${sharedPreferences!.getString("username")} تعليقاً جديداً على منشور تتابعه",
                        title: "مجتمع فايتور",
                        navigation: "COMMENT",
                        id: widget.postId,
                        createdBy_id: widget.createdBy_id,
                      );
                    }
                    Navigator.pop(context);
                    _textEditingController.clear();
                  } else if (state.addCommentState == RequestState.error ||
                      state.updateCommentState == RequestState.error) {
                    Navigator.pop(context);
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
                            //print("-----------------");
                            //print(widget.createdBy_id.toString());
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
