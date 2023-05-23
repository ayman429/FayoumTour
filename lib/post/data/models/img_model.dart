import '../../domain/entities/img.dart';

class ImagesPModel extends ImagesP {
  ImagesPModel({required super.imageP});

  factory ImagesPModel.fromJson(Map<String, dynamic> json) =>
      ImagesPModel(imageP: json['image']);
}
