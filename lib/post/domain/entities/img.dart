import 'package:equatable/equatable.dart';

class ImagesP extends Equatable {
  String imageP;
  ImagesP({
    required this.imageP,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = imageP;
    return data;
  }

  @override
  List<Object> get props => [imageP];
}
