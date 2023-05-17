import '../../../core/utils/enums.dart';
import '../../domain/entities/tourism_place.dart';

class TourismPlaceState {
  final List<TourismPlace> tourismPlace;
  final RequestState tourismPlaceState;
  final String tourismPlaceMessage;

  final List<TourismPlace> searchTourismPlace;
  final RequestState searchTourismPlaceState;
  final String searchTourismPlaceMessage;

  final TourismPlace? tourismPlaceById;
  final RequestState tourismPlaceStateById;
  final String tourismPlaceMessageById;

  TourismPlaceState({
    this.tourismPlace = const [],
    this.tourismPlaceState = RequestState.loading,
    this.tourismPlaceMessage = '',
    this.tourismPlaceById,
    this.tourismPlaceStateById = RequestState.loading,
    this.tourismPlaceMessageById = '',
    this.searchTourismPlace = const [],
    this.searchTourismPlaceState = RequestState.loading,
    this.searchTourismPlaceMessage = '',
  });

  TourismPlaceState copyWith({
    List<TourismPlace>? tourismPlace,
    RequestState? tourismPlaceState,
    String? tourismPlaceMessage,
    TourismPlace? tourismPlaceById,
    RequestState? tourismPlaceStateById,
    String? tourismPlaceMessageById,
    List<TourismPlace>? searchTourismPlace,
    RequestState? searchTourismPlaceState,
    String? searchTourismPlaceMessage,
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
      searchTourismPlace: searchTourismPlace ?? this.searchTourismPlace,
      searchTourismPlaceState:
          searchTourismPlaceState ?? this.searchTourismPlaceState,
      searchTourismPlaceMessage:
          searchTourismPlaceMessage ?? this.searchTourismPlaceMessage,
    );
  }
}
