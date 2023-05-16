import 'package:equatable/equatable.dart';

class Images2 extends Equatable {
  String imageT;
  Images2({
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
