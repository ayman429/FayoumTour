import '../../domain/entities/tourism_place_favorite.dart';

class TourismPlaceFavoriteModel extends TourismPlaceFavorite {
  const TourismPlaceFavoriteModel(
      {required super.id,
      required super.fav,
      required super.placeId,
      required super.user});

  factory TourismPlaceFavoriteModel.fromJson(Map<String, dynamic> json) {
    return TourismPlaceFavoriteModel(
      id: json['id'],
      fav: json['fav'],
      placeId: json['placeId'],
      user: json['user'],
    );
  }

  TourismPlaceFavoriteModel.castFromEntity(
      final TourismPlaceFavorite placeFavorite)
      : super(
            id: placeFavorite.id,
            user: placeFavorite.user,
            placeId: placeFavorite.placeId,
            fav: placeFavorite.fav);
}
