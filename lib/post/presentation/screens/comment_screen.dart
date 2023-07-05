import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/constance/strings_manager.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/snackbar_message.dart';
import '../../domain/entities/comment.dart';
import '../controller/bloc/post_bloc.dart';
import 'get_comment.dart';

class CommentScreen extends StatefulWidget {
  int postId;
  CommentScreen({
    Key? key,
    required this.postId,
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
          title: const Text(
            'Comments',
            style: TextStyle(
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          centerTitle: true,
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(left: 35),
          child: TextField(
          
            controller: _textEditingController,
            decoration: InputDecoration(
              
              filled: true,
              fillColor: Theme.of(context).colorScheme.tertiaryContainer,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              hintText: "Write a comment...",
              hintStyle: const TextStyle(color: Colors.grey),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              suffixIcon: BlocConsumer<PostBloc, PostState>(
                listener: (context, state) {
                  if (state.addCommentState == RequestState.loaded ||
                      state.updateCommentState == RequestState.loaded) {
                    // BlocProvider.of<PostBloc>(context)
                    //     .add(GetCommentEvent(postId: widget.postId));
                    print("Loded");
                    // Navigator.pop(context);
                    _textEditingController.clear();
                  } else if (state.addCommentState == RequestState.loading ||
                      state.updateCommentState == RequestState.loading) {
                    print("Comment Loding");

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
