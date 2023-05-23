import 'package:equatable/equatable.dart';

import 'created_by.dart';
import 'img.dart';

class Post extends Equatable {
  int user;
  String body;
  List<ImagesP> imagesP;
  CreatedBy? createdBy;

  Post({
    required this.user,
    required this.body,
    required this.imagesP,
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
