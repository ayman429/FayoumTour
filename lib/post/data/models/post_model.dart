import '../../domain/entities/post.dart';
import 'created_by_model.dart';
import 'img_model.dart';

class PostModel extends Post {
  PostModel(
      {required super.user,
      required super.body,
      required super.imagesP,
      required super.createdBy});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    List<ImagesPModel> image = <ImagesPModel>[];
    json['images'] != null
        ? json['images'].forEach((v) {
            image.add(ImagesPModel.fromJson(v));
          })
        : [];

    return PostModel(
      body: json['body'],
      imagesP: image,
      user: json['user'],
      createdBy: CreatedByModel.fromJson(json['created_by']),
    );
  }
  PostModel.castFromEntity(final Post post)
      : super(
            user: post.user,
            body: post.body,
            imagesP: post.imagesP,
            createdBy: post.createdBy);
}
