import 'package:equatable/equatable.dart';

class PostData extends Equatable {
  final String body;
  final List<String> images;
  final String createdAt;
  const PostData({
    required this.body,
    required this.images,
    required this.createdAt,
  });

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['body'] = body;
  //   data['images'] = images;
  //   data['createdAt'] = createdAt;

  //   return data;
  // }

  @override
  List<Object> get props => [body, images, createdAt];
}
