import '../../domain/entities/Images.dart';

class ImagesModel extends Images {
  ImagesModel({required super.image});

  factory ImagesModel.fromJson(Map<String, dynamic> json) {
    // print("object= ${json['image']}");
    return ImagesModel(
      image: json['image'],
    );
  }
}
