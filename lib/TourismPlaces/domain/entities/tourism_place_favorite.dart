import 'package:equatable/equatable.dart';

class TourismPlaceFavorite extends Equatable {
  int? id;
  int fav;
  int? placeId;
  int user;
  TourismPlaceFavorite({
    this.id,
    required this.fav,
    this.placeId,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    placeId != null ? data['placeId'] = placeId : null;
    data['fav'] = fav;
    data['username'] = user;

    return data;
  }

  @override
  List<Object> get props => [fav, user];
}
