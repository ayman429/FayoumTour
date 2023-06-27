import '../../domain/entities/hotel.dart';
import '../../domain/entities/hotel_rate.dart';
import '../../domain/entities/hotel_reservation.dart';

abstract class HotelsEvent {
  const HotelsEvent();
}

class GetHotelsEvent extends HotelsEvent {}

class GetHotelsByIdEvent extends HotelsEvent {
  String hotelsId;
  GetHotelsByIdEvent({
    required this.hotelsId,
  });
}

class AddHotelEvent extends HotelsEvent {
  Hotel hotel;
  AddHotelEvent({
    required this.hotel,
  });
}

class UpdateHotelEvent extends HotelsEvent {
  Hotel hotel;
  UpdateHotelEvent({
    required this.hotel,
  });
}

class DeleteHotelEvent extends HotelsEvent {
  String hotelsId;
  DeleteHotelEvent({
    required this.hotelsId,
  });
}

class SearchHotelByFieldsEvent extends HotelsEvent {
  String hotelSearchByFeild;
  SearchHotelByFieldsEvent({
    required this.hotelSearchByFeild,
  });
}

class SearchHotelByRateEvent extends HotelsEvent {}

class OrderingHotelByFieldsEvent extends HotelsEvent {
  String hotelOrderingByFeild;
  OrderingHotelByFieldsEvent({
    required this.hotelOrderingByFeild,
  });
}

class GetHotelRatesEvent extends HotelsEvent {}

class GetHotelRateByIdEvent extends HotelsEvent {
  String hotelRateId;
  GetHotelRateByIdEvent({
    required this.hotelRateId,
  });
}

class UpdateCreateHotelRatesEvent extends HotelsEvent {
  HotelRate updateCreateHotelRate;
  String hotelID;
  UpdateCreateHotelRatesEvent({
    required this.updateCreateHotelRate,
    required this.hotelID,
  });
}

// HotelReservation
class GetHotelsReservationEvent extends HotelsEvent {
  int hotelId;
  GetHotelsReservationEvent({
    required this.hotelId,
  });
}

class GetHotelsReservationByUserEvent extends HotelsEvent {
  int userId;
  GetHotelsReservationByUserEvent({
    required this.userId,
  });
}

class AddHotelReservationEvent extends HotelsEvent {
  HotelReservation hotelReservation;
  AddHotelReservationEvent({
    required this.hotelReservation,
  });
}

class UpdateHotelReservationEvent extends HotelsEvent {
  HotelReservation hotelReservation;
  UpdateHotelReservationEvent({
    required this.hotelReservation,
  });
}

class DeleteHotelReservationEvent extends HotelsEvent {
  String hotelsId;
  DeleteHotelReservationEvent({
    required this.hotelsId,
  });
}
