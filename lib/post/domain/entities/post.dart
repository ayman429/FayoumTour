import 'package:equatable/equatable.dart';

import 'created_by.dart';
import 'img.dart';

class Post extends Equatable {
  final String? id;
  final int user;
  final String body;
  final List<ImagesP> imagesP;
  final String? comment_numbers;
  final String? like_numbers;
  final int? like_value;
  final String? createdAt;
  final CreatedBy? createdBy;

  const Post({
    this.id,
    required this.user,
    required this.body,
    required this.imagesP,
    this.comment_numbers,
    this.like_numbers,
    this.like_value,
    this.createdAt,
    this.createdBy,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['body'] = body;
    data['images'] = imagesP.map((v) => v.toJson()).toList();
    data['user'] = user;
    // data['created_by'] = createdBy;
    return data;
  }

  @override
  List<Object> get props => [user, body, imagesP];
}
