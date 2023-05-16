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

class GetTourismPlaceRates extends TourismPlaceEvent {}

class GetTourismPlaceRateById extends TourismPlaceEvent {}

class UpdateCreateTourismPlaceRates extends TourismPlaceEvent {}
