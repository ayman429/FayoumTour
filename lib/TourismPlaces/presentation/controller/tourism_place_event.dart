import '../../domain/entities/tourism_place.dart';
import '../../domain/entities/tourism_place_favorite.dart';
import '../../domain/entities/tourism_place_rate.dart';

abstract class TourismPlaceEvent {
  const TourismPlaceEvent();
}

class GetTourismPlaceEvent extends TourismPlaceEvent {}

class GetTourismPlacesByIdEvent extends TourismPlaceEvent {
  String tourId;
  GetTourismPlacesByIdEvent({
    required this.tourId,
  });
}

class AddTourismPlaceEvent extends TourismPlaceEvent {
  TourismPlace tourismPlace;
  AddTourismPlaceEvent({
    required this.tourismPlace,
  });
}

class UpdateTourismPlaceEvent extends TourismPlaceEvent {
  TourismPlace tourismPlace;
  UpdateTourismPlaceEvent({
    required this.tourismPlace,
  });
}

class DeleteTourismPlaceEvent extends TourismPlaceEvent {
  String tourId;
  DeleteTourismPlaceEvent({
    required this.tourId,
  });
}

class SearchTourismPlaceByFieldsEvent extends TourismPlaceEvent {
  String tourismPlaceSearchByFeild;
  SearchTourismPlaceByFieldsEvent({
    required this.tourismPlaceSearchByFeild,
  });
}

class Model1Event extends TourismPlaceEvent {
  String model1Input;
  Model1Event({
    required this.model1Input,
  });
}

class OrderingTourismPlaceByFieldsEvent extends TourismPlaceEvent {
  String tourismPlaceOrderingByFeild;
  OrderingTourismPlaceByFieldsEvent({
    required this.tourismPlaceOrderingByFeild,
  });
}

class SearchTourismPlaceByRateEvent extends TourismPlaceEvent {}

class GetTourismPlaceRatesEvent extends TourismPlaceEvent {}

class GetTourismPlaceRateByIdEvent extends TourismPlaceEvent {
  String tourRateId;
  GetTourismPlaceRateByIdEvent({
    required this.tourRateId,
  });
}

class UpdateCreateTourismPlaceRatesEvent extends TourismPlaceEvent {
  TourismPlaceRate updateCreateTourRate;
  String tourismPlaceID;
  UpdateCreateTourismPlaceRatesEvent({
    required this.updateCreateTourRate,
    required this.tourismPlaceID,
  });
}

class GetTourismPlaceRateByUserEvent extends TourismPlaceEvent {
  int placeId;
  int userId;
  GetTourismPlaceRateByUserEvent({
    required this.placeId,
    required this.userId,
  });
}

class UpdateCreateTourismPlaceFavoriteEvent extends TourismPlaceEvent {
  TourismPlaceFavorite updateCreateTourFavorite;
  UpdateCreateTourismPlaceFavoriteEvent({
    required this.updateCreateTourFavorite,
  });
}

class GetTourismPlaceFavoriteEvent extends TourismPlaceEvent {
  TourismPlaceFavorite getTourFavorite;
  GetTourismPlaceFavoriteEvent({
    required this.getTourFavorite,
  });
}
