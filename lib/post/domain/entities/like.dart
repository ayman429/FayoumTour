import 'package:equatable/equatable.dart';

class Like extends Equatable {
  final int? id;
  final int like;
  final int postId;
  final int user;
  const Like({
    this.id,
    required this.like,
    required this.postId,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['like'] = like;
    data['username'] = user;

    return data;
  }

  @override
  List<Object> get props => [user, postId, like];
}
