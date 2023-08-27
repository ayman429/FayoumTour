import '../../domain/entities/img.dart';

class ImagesPModel extends ImagesP {
  const ImagesPModel({required super.imageT});

  factory ImagesPModel.fromJson(Map<String, dynamic> json) =>
      ImagesPModel(imageT: json['image']);
}
