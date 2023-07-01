import 'package:equatable/equatable.dart';

class HotelRate extends Equatable {
  int? id;
  int stars;
  int? hotel;
  int user;
  HotelRate({
    this.id,
    required this.stars,
    this.hotel,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['stars'] = stars;
    data['username'] = user;

    return data;
  }

  @override
  List<Object> get props => [stars, user];
}
