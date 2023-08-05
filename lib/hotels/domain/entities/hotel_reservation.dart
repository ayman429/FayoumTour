import 'package:equatable/equatable.dart';

import 'created_by.dart';

class HotelReservation {
  String? id;
  int? hotel;
  String? hotelImage;
  String? hotelName;
  String? hotelNameAR;
  int? user;
  String? phone_number;
  int? adulls;
  int? kids;
  String? check_in;
  String? check_out;
  String? created_at;
  String? updated_at;
  CreatedBy? createdBy;
  String? status;
  HotelReservation({
    this.id,
    this.hotel,
    this.hotelImage,
    this.hotelName,
    this.hotelNameAR,
    this.user,
    this.phone_number,
    this.adulls,
    this.kids,
    this.check_in,
    this.check_out,
    this.created_at,
    this.updated_at,
    this.createdBy,
    this.status,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    id != null ? data['id'] = id : null;
    hotel != null ? data['hotel'] = hotel : null;
    user != null ? data['user'] = user : null;
    phone_number != null ? data['phone_number'] = phone_number : null;
    adulls != null ? data['adulls'] = adulls : null;
    kids != null ? data['kids'] = kids : null;
    check_in != null ? data['check_in'] = check_in : null;
    check_out != null ? data['check_out'] = check_out : null;
    created_at != null ? data['created_at'] = created_at : null;
    status != null ? data['status'] = status : null;

    return data;
  }
}
