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
  Post post;
  UpdatePostEvent({
    required this.post,
  });
}

class DeletePostEvent extends PostEvent {
  String postId;
  DeletePostEvent({
    required this.postId,
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
