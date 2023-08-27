// ignore_for_file: non_constant_identifier_names

import '../../domain/entities/post.dart';
import 'created_by_model.dart';
import 'img_model.dart';

class PostModel extends Post {
  const PostModel(
      {required super.id,
      required super.user,
      required super.body,
      required super.imagesP,
      required super.comment_numbers,
      required super.like_numbers,
      required super.like_value,
      required super.createdAt,
      required super.createdBy});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    List<ImagesPModel> image = <ImagesPModel>[];
    json['images'] != null
        ? json['images'].forEach((v) {
            image.add(ImagesPModel.fromJson(v));
          })
        : [];

    return PostModel(
      id: json['id'].toString(),
      body: json['body'],
      imagesP: image,
      user: json['user'],
      comment_numbers: json['comment_numbers'],
      like_numbers: json['like_numbers'],
      like_value: json['like_value'],
      createdAt: json['created_at'],
      createdBy: CreatedByModel.fromJson(json['created_by']),
    );
  }
  PostModel.castFromEntity(final Post post)
      : super(
            id: post.id,
            user: post.user,
            body: post.body,
            imagesP: post.imagesP,
            comment_numbers: post.comment_numbers,
            like_numbers: post.like_numbers,
            like_value: post.like_value,
            createdBy: post.createdBy);
}
