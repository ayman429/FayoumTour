import 'package:equatable/equatable.dart';

import 'created_by.dart';
import 'img.dart';

class Comment extends Equatable {
  String? id;
  int? user;
  int? post;
  String comment;
  String? created_at;
  String? updated_at;
  CreatedBy? createdBy;

  Comment({
    this.id,
    this.user,
    this.post,
    required this.comment,
    this.updated_at,
    this.created_at,
    this.createdBy,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['post'] = post;
    data['user'] = user;
    data['comment'] = comment;
    // data['created_by'] = createdBy;
    return data;
  }

  @override
  List<Object> get props {
    return [
      comment,
    ];
  }
}
