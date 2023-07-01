import 'package:equatable/equatable.dart';

import 'created_by.dart';
import 'img.dart';

class Post extends Equatable {
  String? id;
  int user;
  String body;
  List<ImagesP> imagesP;
  String? comment_numbers;
  String? like_numbers;
  CreatedBy? createdBy;

  Post({
    this.id,
    required this.user,
    required this.body,
    required this.imagesP,
    this.comment_numbers,
    this.like_numbers,
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
