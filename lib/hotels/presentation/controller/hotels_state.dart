import 'package:fayoumtour/hotels/domain/entities/hotel_rate.dart';

import '../../../core/utils/enums.dart';
import '../../domain/entities/hotel.dart';
import '../../domain/entities/hotel_reservation.dart';

class HotelsState {
  final List<Hotel> hotels;
  final RequestState hotelState;
  final String hotelMessage;

  final Hotel? hotelsById;
  final RequestState hotelStateById;
  final String hotelMessageById;

  final RequestState addHotelState;
  final String addHotelMessage;

  final RequestState updateHotelState;
  final String updateHotelMessage;

  final RequestState deleteHotelState;
  final String deleteHotelMessage;

  final List<Hotel> searchHotels;
  final RequestState searchHotelState;
  final String searchHotelsMessage;

  final List<Hotel> searchHotelRate;
  final RequestState searchHotelRateState;
  final String searchHotelRateMessage;

  final List<Hotel> orderingHotel;
  final RequestState orderingHotelState;
  final String orderingHotelMessage;

  final List<HotelRate> getHotelRate;
  final RequestState getHotelRateState;
  final String getHotelRateMessage;

  final HotelRate? getHotelRateById;
  final RequestState getHotelRateByIdState;
  final String getHotelRateByIdMessage;

  final RequestState updateCreateHotelRateState;
  final String updateCreateHotelRateMessage;

  final String getHotelRateByUser;
  final RequestState getHotelRateByUserState;
  final String getHotelRateByUserMessage;

  final RequestState updateCreateHotelFavoriteState;
  final String updateCreateHotelFavoriteMessage;

  final List<Hotel> getHotelFavorite;
  final RequestState getHotelFavoriteState;
  final String getHotelFavoriteMessage;

  // HotelReservation
  final List<HotelReservation> hotelsReservation;
  final RequestState hotelReservationState;
  final String hotelReservationMessage;

  final List<HotelReservation> hotelsReservationByUser;
  final RequestState hotelReservationByUserState;
  final String hotelReservationByUserMessage;

  final RequestState addHotelReservationState;
  final String addHotelReservationMessage;

  final RequestState updateHotelReservationState;
  final String updateHotelReservationMessage;
  final RequestState updateHotelReservationByUserState;
  final String updateHotelReservationByUserMessage;

  final RequestState deleteHotelReservationState;
  final String deleteHotelReservationMessage;

  HotelsState({
    this.addHotelState = RequestState.loading,
    this.addHotelMessage = '',
    this.updateHotelState = RequestState.loading,
    this.updateHotelMessage = '',
    this.deleteHotelState = RequestState.loading,
    this.deleteHotelMessage = '',
    this.searchHotelRate = const [],
    this.searchHotelRateState = RequestState.loading,
    this.searchHotelRateMessage = '',
    this.orderingHotel = const [],
    this.orderingHotelState = RequestState.loading,
    this.orderingHotelMessage = '',
    this.getHotelRate = const [],
    this.getHotelRateState = RequestState.loading,
    this.getHotelRateMessage = '',
    this.getHotelRateById,
    this.getHotelRateByIdState = RequestState.loading,
    this.getHotelRateByIdMessage = '',
    this.updateCreateHotelRateState = RequestState.loading,
    this.updateCreateHotelRateMessage = '',
    this.getHotelRateByUser = '',
    this.getHotelRateByUserState = RequestState.loading,
    this.getHotelRateByUserMessage = '',
    this.searchHotels = const [],
    this.searchHotelState = RequestState.loading,
    this.searchHotelsMessage = '',
    this.hotels = const [],
    this.hotelState = RequestState.loading,
    this.hotelMessage = '',
    this.hotelsById,
    this.hotelStateById = RequestState.loading,
    this.hotelMessageById = '',
    this.updateCreateHotelFavoriteState = RequestState.loading,
    this.updateCreateHotelFavoriteMessage = '',
    this.getHotelFavorite = const [],
    this.getHotelFavoriteState = RequestState.loading,
    this.getHotelFavoriteMessage = '',

    // HotelReservation
    this.hotelsReservation = const [],
    this.hotelReservationState = RequestState.loading,
    this.hotelReservationMessage = '',
    this.hotelsReservationByUser = const [],
    this.hotelReservationByUserState = RequestState.loading,
    this.hotelReservationByUserMessage = '',
    this.addHotelReservationState = RequestState.loading,
    this.addHotelReservationMessage = '',
    this.updateHotelReservationState = RequestState.loading,
    this.updateHotelReservationMessage = '',
    this.updateHotelReservationByUserState = RequestState.loading,
    this.updateHotelReservationByUserMessage = '',
    this.deleteHotelReservationState = RequestState.loading,
    this.deleteHotelReservationMessage = '',
  });

  HotelsState copyWith({
    List<Hotel>? hotels,
    RequestState? hotelState,
    String? hotelMessage,
    Hotel? hotelsById,
    RequestState? hotelStateById,
    String? hotelMessageById,
    RequestState? addHotelState,
    String? addHotelMessage,
    RequestState? updateHotelState,
    String? updateHotelMessage,
    RequestState? deleteHotelState,
    String? deleteHotelMessage,
    List<Hotel>? searchHotels,
    RequestState? searchHotelState,
    String? searchHotelsMessage,
    List<Hotel>? searchHotelRate,
    RequestState? searchHotelRateState,
    String? searchHotelRateMessage,
    List<Hotel>? orderingHotel,
    RequestState? orderingHotelState,
    String? orderingHotelMessage,
    List<HotelRate>? getHotelRate,
    RequestState? getHotelRateState,
    String? getHotelRateMessage,
    HotelRate? getHotelRateById,
    RequestState? getHotelRateByIdState,
    String? getHotelRateByIdMessage,
    RequestState? updateCreateHotelRateState,
    String? updateCreateHotelRateMessage,
    String? getHotelRateByUser,
    RequestState? getHotelRateByUserState,
    String? getHotelRateByUserMessage,
    RequestState? updateCreateHotelFavoriteState,
    String? updateCreateHotelFavoriteMessage,
    List<Hotel>? getHotelFavorite,
    RequestState? getHotelFavoriteState,
    String? getHotelFavoriteMessage,

    // HotelReservation
    List<HotelReservation>? hotelsReservation,
    RequestState? hotelReservationState,
    String? hotelReservationMessage,
    List<HotelReservation>? hotelsReservationByUser,
    RequestState? hotelReservationByUserState,
    String? hotelReservationByUserMessage,
    RequestState? addHotelReservationState,
    String? addHotelReservationMessage,
    RequestState? updateHotelReservationState,
    String? updateHotelReservationMessage,
    RequestState? updateHotelReservationByUserState,
    String? updateHotelReservationByUserMessage,
    RequestState? deleteHotelReservationState,
    String? deleteHotelReservationMessage,
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
      addHotelState: addHotelState ?? this.addHotelState,
      addHotelMessage: addHotelMessage ?? this.addHotelMessage,
      updateHotelState: updateHotelState ?? this.updateHotelState,
      updateHotelMessage: updateHotelMessage ?? this.updateHotelMessage,
      deleteHotelState: deleteHotelState ?? this.deleteHotelState,
      deleteHotelMessage: deleteHotelMessage ?? this.deleteHotelMessage,
      searchHotelRate: searchHotelRate ?? this.searchHotelRate,
      searchHotelRateState: searchHotelRateState ?? this.searchHotelRateState,
      searchHotelRateMessage:
          searchHotelRateMessage ?? this.searchHotelRateMessage,
      orderingHotel: orderingHotel ?? this.orderingHotel,
      orderingHotelState: orderingHotelState ?? this.orderingHotelState,
      orderingHotelMessage: orderingHotelMessage ?? this.orderingHotelMessage,
      getHotelRate: getHotelRate ?? this.getHotelRate,
      getHotelRateState: getHotelRateState ?? this.getHotelRateState,
      getHotelRateMessage: getHotelRateMessage ?? this.getHotelRateMessage,
      getHotelRateById: getHotelRateById ?? this.getHotelRateById,
      getHotelRateByIdState:
          getHotelRateByIdState ?? this.getHotelRateByIdState,
      getHotelRateByIdMessage:
          getHotelRateByIdMessage ?? this.getHotelRateByIdMessage,
      updateCreateHotelRateMessage:
          updateCreateHotelRateMessage ?? this.updateCreateHotelRateMessage,
      updateCreateHotelRateState:
          updateCreateHotelRateState ?? this.updateCreateHotelRateState,

      getHotelRateByUser: getHotelRateByUser ?? this.getHotelRateByUser,
      getHotelRateByUserState:
          getHotelRateByUserState ?? this.getHotelRateByUserState,
      getHotelRateByUserMessage:
          getHotelRateByUserMessage ?? this.getHotelRateByUserMessage,

      updateCreateHotelFavoriteState:
          updateCreateHotelFavoriteState ?? this.updateCreateHotelFavoriteState,
      updateCreateHotelFavoriteMessage: updateCreateHotelFavoriteMessage ??
          this.updateCreateHotelFavoriteMessage,
      getHotelFavorite: getHotelFavorite ?? this.getHotelFavorite,
      getHotelFavoriteState:
          getHotelFavoriteState ?? this.getHotelFavoriteState,
      getHotelFavoriteMessage:
          getHotelFavoriteMessage ?? this.getHotelFavoriteMessage,

      // HotelReservation
      hotelsReservation: hotelsReservation ?? this.hotelsReservation,
      hotelReservationState:
          hotelReservationState ?? this.hotelReservationState,
      hotelReservationMessage:
          hotelReservationMessage ?? this.hotelReservationMessage,
      hotelsReservationByUser:
          hotelsReservationByUser ?? this.hotelsReservationByUser,
      hotelReservationByUserState:
          hotelReservationByUserState ?? this.hotelReservationByUserState,
      hotelReservationByUserMessage:
          hotelReservationByUserMessage ?? this.hotelReservationByUserMessage,
      addHotelReservationState:
          addHotelReservationState ?? this.addHotelReservationState,
      addHotelReservationMessage:
          addHotelReservationMessage ?? this.addHotelReservationMessage,
      updateHotelReservationState:
          updateHotelReservationState ?? this.updateHotelReservationState,
      updateHotelReservationMessage:
          updateHotelReservationMessage ?? this.updateHotelReservationMessage,
      updateHotelReservationByUserState: updateHotelReservationByUserState ??
          this.updateHotelReservationByUserState,
      updateHotelReservationByUserMessage:
          updateHotelReservationByUserMessage ??
              this.updateHotelReservationByUserMessage,
      deleteHotelReservationState:
          deleteHotelReservationState ?? this.deleteHotelReservationState,
      deleteHotelReservationMessage:
          deleteHotelReservationMessage ?? this.deleteHotelReservationMessage,
    );
  }
}
