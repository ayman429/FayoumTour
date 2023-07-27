import '../../domain/entities/hotel_reservation.dart';
import 'created_by_model.dart';

class HotelReservationModel extends HotelReservation {
  HotelReservationModel(
      {required super.id,
      required super.hotel,
      required super.hotelImage,
      required super.hotelName,
      required super.hotelNameAR,
      required super.user,
      required super.phone_number,
      required super.adulls,
      required super.kids,
      required super.check_in,
      required super.check_out,
      required super.created_at,
      required super.updated_at,
      required super.createdBy});

  factory HotelReservationModel.fromJson(Map<String, dynamic> json) {
    return HotelReservationModel(
      id: json['id'].toString(),
      hotel: json['hotel'],
      hotelImage: json['hotelImage'],
      hotelName: json['hotelName'],
      hotelNameAR: json['hotelNameAR'],
      user: json['user'],
      phone_number: json['phone_number'],
      adulls: json['adulls'],
      kids: json['kids'],
      check_in: json['check_in'],
      check_out: json['check_out'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      createdBy: CreatedByModel.fromJson(json['created_by'] ?? {}),
    );
  }
  HotelReservationModel.castFromEntity(final HotelReservation hotelReservation)
      : super(
            id: hotelReservation.id,
            hotel: hotelReservation.hotel,
            hotelImage: hotelReservation.hotelImage,
            hotelName: hotelReservation.hotelName,
            hotelNameAR: hotelReservation.hotelNameAR,
            user: hotelReservation.user,
            phone_number: hotelReservation.phone_number,
            adulls: hotelReservation.adulls,
            kids: hotelReservation.kids,
            check_in: hotelReservation.check_in,
            check_out: hotelReservation.check_out,
            created_at: hotelReservation.created_at,
            updated_at: hotelReservation.updated_at,
            createdBy: hotelReservation.createdBy);
}
