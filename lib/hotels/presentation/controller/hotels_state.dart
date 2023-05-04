import '../../../core/utils/enums.dart';
import '../../domain/entities/hotel.dart';

class HotelsState {
  final List<Hotel> hotels;
  final RequestState hotelState;
  final String message;

  HotelsState({
    this.hotels = const [],
    this.hotelState = RequestState.loading,
    this.message = '',
  });
}
