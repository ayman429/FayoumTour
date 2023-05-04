import '../../domain/entities/hotel_rate.dart';

class HotelRateModel extends HotelRate {
  HotelRateModel(
      {required super.id,
      required super.stars,
      required super.hotel,
      required super.user});

  factory HotelRateModel.fromJson(Map<String, dynamic> json) {
    return HotelRateModel(
      id: json['id'],
      stars: json['stars'],
      hotel: json['hotel'],
      user: json['user'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['stars'] = stars;
    data['username'] = user;

    return data;
  }

  HotelRateModel.castFromEntity(final HotelRate hotel)
      : super(
            id: hotel.id,
            user: hotel.user,
            hotel: hotel.hotel,
            stars: hotel.stars);
}
