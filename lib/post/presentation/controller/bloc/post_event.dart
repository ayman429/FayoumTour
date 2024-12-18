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
  PostData postData;
  AddPostEvent({
    required this.postData,
  });
}

class UpdatePostEvent extends PostEvent {
  String body;
  List<String> images;
  String posId;
  String index;
  UpdatePostEvent({
    required this.body,
    required this.images,
    required this.posId,
    required this.index,
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

//Like
class AddLikeEvent extends PostEvent {
  Like like;
  AddLikeEvent({
    required this.like,
  });
}

class GetLikeEvent extends PostEvent {
  int postId;
  int userId;
  GetLikeEvent({required this.postId, required this.userId});
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
