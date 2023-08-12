import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';
import 'comment_screen.dart';
import 'comments.dart';
import '../controller/bloc/post_bloc.dart';

List ids = [];

class GetComment extends StatelessWidget {
  final int postId;
  const GetComment({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      return getIt<PostBloc>();
    }, child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      //print(state.commentState);
      BlocProvider.of<PostBloc>(context).add(GetCommentEvent(postId: postId));
      switch (state.commentState) {
        case RequestState.loading:
          return const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()));
        case RequestState.loaded:
          commentIds = {};
          ids = [];
          for (var element in state.comment) {
            ids.contains(element.createdBy!.id)
                ? null
                : ids.add(element.createdBy!.id);
          }
          commentIds.addAll({int.parse("$postId"): ids});
          // print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
          // print(commentIds);
          return CommentList(data: state.comment);
        case RequestState.error:
          return const Center(child: Text("Error"));
      }
    }));
  }
}
