import 'package:equatable/equatable.dart';

class ImagesP extends Equatable {
  final String imageT;
  const ImagesP({
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
