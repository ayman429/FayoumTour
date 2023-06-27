import 'package:equatable/equatable.dart';

import 'created_by.dart';

class HotelReservation {
  String? id;
  int? hotel;
  String? hotelImage;
  String? hotelName;
  int? user;
  String? phone_number;
  int? adulls;
  int? kids;
  String? check_in;
  String? check_out;
  String? created_at;
  String? updated_at;
  CreatedBy? createdBy;
  HotelReservation({
    this.id,
    this.hotel,
    this.hotelImage,
    this.hotelName,
    this.user,
    this.phone_number,
    this.adulls,
    this.kids,
    this.check_in,
    this.check_out,
    this.created_at,
    this.updated_at,
    this.createdBy,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['hotel'] = hotel;
    data['user'] = user;
    data['phone_number'] = phone_number;
    data['adulls'] = adulls;
    data['kids'] = kids;
    data['check_in'] = check_in;
    data['check_out'] = check_out;

    return data;
  }
}
