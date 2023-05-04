import 'package:equatable/equatable.dart';

class Images2 extends Equatable {
  String image2;
  Images2({
    required this.image2,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image2;
    return data;
  }

  @override
  List<Object> get props => [image2];
}
