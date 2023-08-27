import '../../domain/entities/like.dart';

class LikeModel extends Like {
  const LikeModel(
      {required super.id,
      required super.like,
      required super.postId,
      required super.user});

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      id: json['id'],
      like: json['like'],
      postId: json['postId'],
      user: json['user'],
    );
  }

  LikeModel.castFromEntity(final Like like)
      : super(
            id: like.id, user: like.user, postId: like.postId, like: like.like);
}
