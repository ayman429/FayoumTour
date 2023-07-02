import 'package:equatable/equatable.dart';

class Like extends Equatable {
  int? id;
  int like;
  int postId;
  int user;
  Like({
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
