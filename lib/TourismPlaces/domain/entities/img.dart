import 'package:equatable/equatable.dart';

class ImagesT extends Equatable {
  final String imageT;
  const ImagesT({
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
