import '../../domain/entities/hotel_favorite.dart';

class HotelFavoriteModel extends HotelFavorite {
  HotelFavoriteModel(
      {required super.id,
      required super.fav,
      required super.hotelId,
      required super.user});

  factory HotelFavoriteModel.fromJson(Map<String, dynamic> json) {
    return HotelFavoriteModel(
      id: json['id'],
      fav: json['fav'],
      hotelId: json['hotelId'],
      user: json['user'],
    );
  }

  HotelFavoriteModel.castFromEntity(final HotelFavorite hotelFavorite)
      : super(
            id: hotelFavorite.id,
            user: hotelFavorite.user,
            hotelId: hotelFavorite.hotelId,
            fav: hotelFavorite.fav);
}
