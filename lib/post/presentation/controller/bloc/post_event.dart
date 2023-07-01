part of 'post_bloc.dart';

abstract class PostEvent {
  const PostEvent();
}

class GetPostEvent extends PostEvent {}

class GetPostByIdEvent extends PostEvent {
  String postId;
  GetPostByIdEvent({
    required this.postId,
  });
}

class AddPostEvent extends PostEvent {
  String body;
  List<String> images;
  AddPostEvent({
    required this.body,
    required this.images,
  });
}

class UpdatePostEvent extends PostEvent {
  String body;
  List<String> images;
  String posId;
  UpdatePostEvent({
    required this.body,
    required this.images,
    required this.posId,
  });
}

class DeletePostEvent extends PostEvent {
  String postId;
  DeletePostEvent({
    required this.postId,
  });
}

// Comment
class GetCommentEvent extends PostEvent {
  int postId;
  GetCommentEvent({
    required this.postId,
  });
}

class AddCommentEvent extends PostEvent {
  Comment comment;
  AddCommentEvent({
    required this.comment,
  });
}

class UpdateCommentEvent extends PostEvent {
  Comment comment;
  UpdateCommentEvent({
    required this.comment,
  });
}

class DeleteCommentEvent extends PostEvent {
  String commentId;
  DeleteCommentEvent({
    required this.commentId,
  });
}

// class SearchPostByFieldsEvent extends PostEvent {
//   String postSearchByFeild;
//   SearchPostByFieldsEvent({
//     required this.postSearchByFeild,
//   });
// }

// class OrderingPostByFieldsEvent extends PostEvent {
//   String postOrderingByFeild;
//   OrderingPostByFieldsEvent({
//     required this.postOrderingByFeild,
//   });
// }
