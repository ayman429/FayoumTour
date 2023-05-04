import 'package:equatable/equatable.dart';

class ImagesT extends Equatable {
  String imageT;
  ImagesT({
    required this.imageT,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = imageT;
    return data;
  }

  @override
  List<Object> get props => [imageT];
}
