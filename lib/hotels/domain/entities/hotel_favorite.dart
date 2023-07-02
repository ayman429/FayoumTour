import 'package:equatable/equatable.dart';

class HotelFavorite extends Equatable {
  int? id;
  int fav;
  int? hotelId;
  int user;
  HotelFavorite({
    this.id,
    required this.fav,
    this.hotelId,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    hotelId != null ? data['hotelId'] = hotelId : null;
    data['fav'] = fav;
    data['username'] = user;

    return data;
  }

  @override
  List<Object> get props => [fav, user];
}
