import '../../domain/entities/tourism_place_rate.dart';

class TourismPlaceRateModel extends TourismPlaceRate {
  TourismPlaceRateModel(
      {required super.id,
      required super.stars,
      required super.touristPlaces,
      required super.user});

  factory TourismPlaceRateModel.fromJson(Map<String, dynamic> json) {
    return TourismPlaceRateModel(
      id: json['id'],
      stars: json['stars'],
      touristPlaces: json['touristPlaces'],
      user: json['user'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['stars'] = stars;
    data['username'] = user;

    return data;
  }

  TourismPlaceRateModel.castFromEntity(final TourismPlaceRate touristPlaces)
      : super(
            id: touristPlaces.id,
            user: touristPlaces.user,
            touristPlaces: touristPlaces.touristPlaces,
            stars: touristPlaces.stars);
}
