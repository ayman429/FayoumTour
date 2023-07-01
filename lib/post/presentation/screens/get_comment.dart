import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';
import '../../../home/comments.dart';
import '../controller/bloc/post_bloc.dart';

class GetComment extends StatelessWidget {
  int postId;
  GetComment({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      return getIt<PostBloc>(); //..add(GetCommentEvent(postId: postId))
    }, child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      print(state.commentState);
      BlocProvider.of<PostBloc>(context).add(GetCommentEvent(postId: postId));
      switch (state.commentState) {
        case RequestState.loading:
          // print("/////////////////////////////////////");
          return const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()));
        case RequestState.loaded:
          // print(state.comment[0].created_at);
          return CommentList(data: state.comment);
        case RequestState.error:
          return const Center(child: Text("Error"));
      }
    }));
  }
}
