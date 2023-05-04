import '../../domain/entities/img.dart';

class ImagesTModel extends ImagesT {
  ImagesTModel({required super.imageT});

  factory ImagesTModel.fromJson(Map<String, dynamic> json) =>
      ImagesTModel(imageT: json['image']);
}
