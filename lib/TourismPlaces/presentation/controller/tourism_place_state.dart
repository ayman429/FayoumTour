import '../../../core/utils/enums.dart';
import '../../domain/entities/tourism_place.dart';
import '../../domain/entities/tourism_place_rate.dart';

class TourismPlaceState {
  final List<TourismPlace> tourismPlace;
  final RequestState tourismPlaceState;
  final String tourismPlaceMessage;

  final TourismPlace? tourismPlaceById;
  final RequestState tourismPlaceStateById;
  final String tourismPlaceMessageById;

  final RequestState addTourismPlaceState;
  final String addTourismPlaceMessage;

  final RequestState updateTourismPlaceState;
  final String updateTourismPlaceMessage;

  final RequestState deleteTourismPlaceState;
  final String deleteTourismPlaceMessage;

  final List<TourismPlace> searchTourismPlace;
  final RequestState searchTourismPlaceState;
  final String searchTourismPlaceMessage;

  final List<TourismPlace> model1;
  final RequestState model1State;
  final String model1Message;

  final List<TourismPlace> searchTourismPlaceRate;
  final RequestState searchTourismPlaceRateState;
  final String searchTourismPlaceRateMessage;

  final List<TourismPlace> orderingTourismPlace;
  final RequestState orderingTourismPlaceState;
  final String orderingTourismPlaceMessage;

  final List<TourismPlaceRate> getTourismPlaceRate;
  final RequestState getTourismPlaceRateState;
  final String getTourismPlaceRateMessage;

  final TourismPlaceRate? getTourismPlaceRateById;
  final RequestState getTourismPlaceRateByIdState;
  final String getTourismPlaceRateByIdMessage;

  final RequestState updateCreateTourismPlaceRateState;
  final String updateCreateTourismPlaceRateMessage;

  final String getTourismPlaceRateByUser;
  final RequestState getTourismPlaceRateByUserState;
  final String getTourismPlaceRateByUserMessage;

  final RequestState updateCreateTourismPlaceFavoriteState;
  final String updateCreateTourismPlaceFavoriteMessage;

  final List<TourismPlace> getTourismPlaceFavorite;
  final RequestState getTourismPlaceFavoriteState;
  final String getTourismPlaceFavoriteMessage;

  TourismPlaceState({
    this.addTourismPlaceState = RequestState.loading,
    this.addTourismPlaceMessage = '',
    this.updateTourismPlaceState = RequestState.loading,
    this.updateTourismPlaceMessage = '',
    this.deleteTourismPlaceState = RequestState.loading,
    this.deleteTourismPlaceMessage = '',
    this.searchTourismPlaceRate = const [],
    this.searchTourismPlaceRateState = RequestState.loading,
    this.searchTourismPlaceRateMessage = '',
    this.orderingTourismPlace = const [],
    this.orderingTourismPlaceState = RequestState.loading,
    this.orderingTourismPlaceMessage = '',
    this.getTourismPlaceRate = const [],
    this.getTourismPlaceRateState = RequestState.loading,
    this.getTourismPlaceRateMessage = '',
    this.getTourismPlaceRateById,
    this.getTourismPlaceRateByIdState = RequestState.loading,
    this.getTourismPlaceRateByIdMessage = '',
    this.updateCreateTourismPlaceRateState = RequestState.loading,
    this.updateCreateTourismPlaceRateMessage = '',
    this.tourismPlace = const [],
    this.tourismPlaceState = RequestState.loading,
    this.tourismPlaceMessage = '',
    this.tourismPlaceById,
    this.tourismPlaceStateById = RequestState.loading,
    this.tourismPlaceMessageById = '',
    this.searchTourismPlace = const [],
    this.searchTourismPlaceState = RequestState.loading,
    this.searchTourismPlaceMessage = '',
    this.model1 = const [],
    this.model1State = RequestState.loading,
    this.model1Message = '',
    this.getTourismPlaceRateByUser = '',
    this.getTourismPlaceRateByUserState = RequestState.loading,
    this.getTourismPlaceRateByUserMessage = '',
    this.updateCreateTourismPlaceFavoriteState = RequestState.loading,
    this.updateCreateTourismPlaceFavoriteMessage = '',
    this.getTourismPlaceFavorite = const [],
    this.getTourismPlaceFavoriteState = RequestState.loading,
    this.getTourismPlaceFavoriteMessage = '',
  });

  TourismPlaceState copyWith({
    List<TourismPlace>? tourismPlace,
    RequestState? tourismPlaceState,
    String? tourismPlaceMessage,
    TourismPlace? tourismPlaceById,
    RequestState? tourismPlaceStateById,
    String? tourismPlaceMessageById,
    RequestState? addTourismPlaceState,
    String? addTourismPlaceMessage,
    RequestState? updateTourismPlaceState,
    String? updateTourismPlaceMessage,
    RequestState? deleteTourismPlaceState,
    String? deleteTourismPlaceMessage,
    List<TourismPlace>? searchTourismPlace,
    RequestState? searchTourismPlaceState,
    String? searchTourismPlaceMessage,
    List<TourismPlace>? model1,
    RequestState? model1State,
    String? model1Message,
    List<TourismPlace>? searchTourismPlaceRate,
    RequestState? searchTourismPlaceRateState,
    String? searchTourismPlaceRateMessage,
    List<TourismPlace>? orderingTourismPlace,
    RequestState? orderingTourismPlaceState,
    String? orderingTourismPlaceMessage,
    List<TourismPlaceRate>? getTourismPlaceRate,
    RequestState? getTourismPlaceRateState,
    String? getTourismPlaceRateMessage,
    TourismPlaceRate? getTourismPlaceRateById,
    RequestState? getTourismPlaceRateByIdState,
    String? getTourismPlaceRateByIdMessage,
    RequestState? updateCreateTourismPlaceRateState,
    String? updateCreateTourismPlaceRateMessage,
    String? getTourismPlaceRateByUser,
    RequestState? getTourismPlaceRateByUserState,
    String? getTourismPlaceRateByUserMessage,
    RequestState? updateCreateTourismPlaceFavoriteState,
    String? updateCreateTourismPlaceFavoriteMessage,
    List<TourismPlace>? getTourismPlaceFavorite,
    RequestState? getTourismPlaceFavoriteState,
    String? getTourismPlaceFavoriteMessage,
  }) {
    return TourismPlaceState(
      tourismPlace: tourismPlace ?? this.tourismPlace,
      tourismPlaceState: tourismPlaceState ?? this.tourismPlaceState,
      tourismPlaceMessage: tourismPlaceMessage ?? this.tourismPlaceMessage,
      tourismPlaceById: tourismPlaceById ?? this.tourismPlaceById,
      tourismPlaceStateById:
          tourismPlaceStateById ?? this.tourismPlaceStateById,
      tourismPlaceMessageById:
          tourismPlaceMessageById ?? this.tourismPlaceMessageById,
      addTourismPlaceState: addTourismPlaceState ?? this.addTourismPlaceState,
      addTourismPlaceMessage:
          addTourismPlaceMessage ?? this.addTourismPlaceMessage,
      updateTourismPlaceState:
          updateTourismPlaceState ?? this.updateTourismPlaceState,
      updateTourismPlaceMessage:
          updateTourismPlaceMessage ?? this.updateTourismPlaceMessage,
      deleteTourismPlaceState:
          deleteTourismPlaceState ?? this.deleteTourismPlaceState,
      deleteTourismPlaceMessage:
          deleteTourismPlaceMessage ?? this.deleteTourismPlaceMessage,
      searchTourismPlace: searchTourismPlace ?? this.searchTourismPlace,
      searchTourismPlaceState:
          searchTourismPlaceState ?? this.searchTourismPlaceState,
      searchTourismPlaceMessage:
          searchTourismPlaceMessage ?? this.searchTourismPlaceMessage,
      model1: model1 ?? this.model1,
      model1State: model1State ?? this.model1State,
      model1Message: model1Message ?? this.model1Message,
      orderingTourismPlace: orderingTourismPlace ?? this.orderingTourismPlace,
      orderingTourismPlaceState:
          orderingTourismPlaceState ?? this.orderingTourismPlaceState,
      orderingTourismPlaceMessage:
          orderingTourismPlaceMessage ?? this.orderingTourismPlaceMessage,
      getTourismPlaceRate: getTourismPlaceRate ?? this.getTourismPlaceRate,
      getTourismPlaceRateState:
          getTourismPlaceRateState ?? this.getTourismPlaceRateState,
      getTourismPlaceRateMessage:
          getTourismPlaceRateMessage ?? this.getTourismPlaceRateMessage,
      getTourismPlaceRateById:
          getTourismPlaceRateById ?? this.getTourismPlaceRateById,
      getTourismPlaceRateByIdState:
          getTourismPlaceRateByIdState ?? this.getTourismPlaceRateByIdState,
      getTourismPlaceRateByIdMessage:
          getTourismPlaceRateByIdMessage ?? this.getTourismPlaceRateByIdMessage,
      searchTourismPlaceRate:
          searchTourismPlaceRate ?? this.searchTourismPlaceRate,
      searchTourismPlaceRateState:
          searchTourismPlaceRateState ?? this.searchTourismPlaceRateState,
      searchTourismPlaceRateMessage:
          searchTourismPlaceRateMessage ?? this.searchTourismPlaceRateMessage,
      updateCreateTourismPlaceRateState: updateCreateTourismPlaceRateState ??
          this.updateCreateTourismPlaceRateState,
      updateCreateTourismPlaceRateMessage:
          updateCreateTourismPlaceRateMessage ??
              this.updateCreateTourismPlaceRateMessage,
      getTourismPlaceRateByUser:
          getTourismPlaceRateByUser ?? this.getTourismPlaceRateByUser,
      getTourismPlaceRateByUserState:
          getTourismPlaceRateByUserState ?? this.getTourismPlaceRateByUserState,
      getTourismPlaceRateByUserMessage: getTourismPlaceRateByUserMessage ??
          this.getTourismPlaceRateByUserMessage,
      updateCreateTourismPlaceFavoriteState:
          updateCreateTourismPlaceFavoriteState ??
              this.updateCreateTourismPlaceFavoriteState,
      updateCreateTourismPlaceFavoriteMessage:
          updateCreateTourismPlaceFavoriteMessage ??
              this.updateCreateTourismPlaceFavoriteMessage,
      getTourismPlaceFavorite:
          getTourismPlaceFavorite ?? this.getTourismPlaceFavorite,
      getTourismPlaceFavoriteState:
          getTourismPlaceFavoriteState ?? this.getTourismPlaceFavoriteState,
      getTourismPlaceFavoriteMessage:
          getTourismPlaceFavoriteMessage ?? this.getTourismPlaceFavoriteMessage,
    );
  }
}
