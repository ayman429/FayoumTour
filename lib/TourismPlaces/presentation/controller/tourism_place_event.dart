abstract class TourismPlaceEvent {
  const TourismPlaceEvent();
}

class GetTourismPlaceEvent extends TourismPlaceEvent {}

class SearchByFieldsEvent extends TourismPlaceEvent {
  String tourismPlaceSearchByFeild;
  SearchByFieldsEvent({
    required this.tourismPlaceSearchByFeild,
  });
}

class GetTourismPlaceRatesEvent extends TourismPlaceEvent {}

class GetTourismPlacesByIdEvent extends TourismPlaceEvent {
  String tourId;
  GetTourismPlacesByIdEvent({
    required this.tourId,
  });
}

class GetTourismPlaceRateByIdEvent extends TourismPlaceEvent {}

class UpdateCreateTourismPlaceRatesEvent extends TourismPlaceEvent {}
