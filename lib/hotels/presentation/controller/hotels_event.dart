abstract class HotelsEvent {
  const HotelsEvent();
}

class GetHotelsEvent extends HotelsEvent {}

class GetHotelsByIdEvent extends HotelsEvent {
  String HotelsId;
  GetHotelsByIdEvent({
    required this.HotelsId,
  });
}

class SearchByFieldsEvent extends HotelsEvent {
  String hotelSearchByFeild;
  SearchByFieldsEvent({
    required this.hotelSearchByFeild,
  });
}
