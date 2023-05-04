import '../../domain/entities/img.dart';

class Images2Model extends Images2 {
  Images2Model({required super.image2});

  factory Images2Model.fromJson(Map<String, dynamic> json) =>
      Images2Model(image2: json['image']);
}
