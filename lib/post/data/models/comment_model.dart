import 'package:fayoumtour/post/domain/entities/comment.dart';

import 'created_by_model.dart';

class CommentModel extends Comment {
  CommentModel(
      {required super.id,
      super.user,
      super.post,
      required super.comment,
      required super.created_at,
      required super.updated_at,
      required super.createdBy});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'].toString(),
      // user: json['user'],
      // post: json['post'],
      comment: json['comment'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      createdBy: CreatedByModel.fromJson(json['created_by']),
    );
  }
  CommentModel.castFromEntity(final Comment comment)
      : super(
            id: comment.id,
            user: comment.user,
            post: comment.post,
            comment: comment.comment,
            created_at: comment.created_at,
            updated_at: comment.created_at,
            createdBy: comment.createdBy);
}
