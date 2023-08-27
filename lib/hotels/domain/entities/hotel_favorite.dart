import 'package:equatable/equatable.dart';

class HotelFavorite extends Equatable {
  final int? id;
  final int fav;
  final int? hotelId;
  final int user;
  const HotelFavorite({
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
