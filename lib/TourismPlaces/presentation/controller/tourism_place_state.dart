import '../../../core/utils/enums.dart';
import '../../domain/entities/tourism_place.dart';

class TourismPlaceState {
  final List<TourismPlace> tourismPlace;
  final RequestState tourismPlaceState;
  final String message;

  TourismPlaceState({
    this.tourismPlace = const [],
    this.tourismPlaceState = RequestState.loading,
    this.message = '',
  });
}
