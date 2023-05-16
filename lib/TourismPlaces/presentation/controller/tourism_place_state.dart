import '../../../core/utils/enums.dart';
import '../../domain/entities/tourism_place.dart';

class TourismPlaceState {
  final List<TourismPlace> tourismPlace;
  final RequestState tourismPlaceState;
  final String tourismPlaceMessage;

  final List<TourismPlace> searchTourismPlace;
  final RequestState searchTourismPlaceState;
  final String searchTourismPlaceMessage;

  TourismPlaceState({
    this.tourismPlace = const [],
    this.tourismPlaceState = RequestState.loading,
    this.tourismPlaceMessage = '',
    this.searchTourismPlace = const [],
    this.searchTourismPlaceState = RequestState.loading,
    this.searchTourismPlaceMessage = '',
  });

  TourismPlaceState copyWith({
    List<TourismPlace>? tourismPlace,
    RequestState? tourismPlaceState,
    String? tourismPlaceMessage,
    List<TourismPlace>? searchTourismPlace,
    RequestState? searchTourismPlaceState,
    String? searchTourismPlaceMessage,
  }) {
    return TourismPlaceState(
      tourismPlace: tourismPlace ?? this.tourismPlace,
      tourismPlaceState: tourismPlaceState ?? this.tourismPlaceState,
      tourismPlaceMessage: tourismPlaceMessage ?? this.tourismPlaceMessage,
      searchTourismPlace: searchTourismPlace ?? this.searchTourismPlace,
      searchTourismPlaceState:
          searchTourismPlaceState ?? this.searchTourismPlaceState,
      searchTourismPlaceMessage:
          searchTourismPlaceMessage ?? this.searchTourismPlaceMessage,
    );
  }
}
