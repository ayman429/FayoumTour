import '../../domain/entities/img.dart';

class Images2Model extends Images2 {
  const Images2Model({required super.imageT});

  factory Images2Model.fromJson(Map<String, dynamic> json) =>
      Images2Model(imageT: json['image']);
}
