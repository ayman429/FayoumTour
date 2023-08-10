import 'package:equatable/equatable.dart';

import 'created_by.dart';

class Comment extends Equatable {
  final String? id;
  final int? user;
  final int? post;
  final String comment;
  final String? created_at;
  final String? updated_at;
  final CreatedBy? createdBy;

  const Comment({
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
