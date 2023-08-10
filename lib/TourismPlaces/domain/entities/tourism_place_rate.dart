import 'package:equatable/equatable.dart';

class TourismPlaceRate extends Equatable {
  final int? id;
  final int stars;
  final int? touristPlaces;
  final int user;
  const TourismPlaceRate({
    this.id,
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
  List<Object> get props => [stars, user];
}
