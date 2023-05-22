import 'package:equatable/equatable.dart';

class TourismPlaceRate extends Equatable {
  int id;
  int stars;
  int? touristPlaces;
  int user;
  TourismPlaceRate({
    required this.id,
    required this.stars,
    this.touristPlaces,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['stars'] = stars;
    data['username'] = user;

    return data;
  }

  @override
  List<Object> get props => [id, stars, user];
}
