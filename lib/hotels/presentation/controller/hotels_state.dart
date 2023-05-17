import '../../../core/utils/enums.dart';
import '../../domain/entities/hotel.dart';

class HotelsState {
  final List<Hotel> hotels;
  final RequestState hotelState;
  final String hotelMessage;

  final Hotel? hotelsById;
  final RequestState hotelStateById;
  final String hotelMessageById;

  final List<Hotel> searchHotels;
  final RequestState searchHotelState;
  final String searchHotelsMessage;
  HotelsState({
    this.searchHotels = const [],
    this.searchHotelState = RequestState.loading,
    this.searchHotelsMessage = '',
    this.hotels = const [],
    this.hotelState = RequestState.loading,
    this.hotelMessage = '',
    this.hotelsById,
    this.hotelStateById = RequestState.loading,
    this.hotelMessageById = '',
  });

  HotelsState copyWith({
    List<Hotel>? hotels,
    RequestState? hotelState,
    String? hotelMessage,
    Hotel? hotelsById,
    RequestState? hotelStateById,
    String? hotelMessageById,
    List<Hotel>? searchHotels,
    RequestState? searchHotelState,
    String? searchHotelsMessage,
  }) {
    return HotelsState(
      hotels: hotels ?? this.hotels,
      hotelState: hotelState ?? this.hotelState,
      hotelMessage: hotelMessage ?? this.hotelMessage,
      hotelsById: hotelsById ?? this.hotelsById,
      hotelStateById: hotelStateById ?? this.hotelStateById,
      hotelMessageById: hotelMessageById ?? this.hotelMessageById,
      searchHotels: searchHotels ?? this.searchHotels,
      searchHotelState: searchHotelState ?? this.searchHotelState,
      searchHotelsMessage: searchHotelsMessage ?? this.searchHotelsMessage,
    );
  }
}
