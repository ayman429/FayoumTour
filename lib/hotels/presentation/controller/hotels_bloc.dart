import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fayoumtour/hotels/domain/usecase/hotel_reservation/get_hotel_usecase_by_user.dart';

import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/enums.dart';
import '../../../hotels/domain/usecase/get_hotel_usecase.dart';
import '../../domain/usecase/add_hotel_usecase.dart';
import '../../domain/usecase/delete_hotel_usecase.dart';
import '../../domain/usecase/favorite/get_hotel_favorite_usecase.dart';
import '../../domain/usecase/favorite/update_or_create_hotel_favorite_usecase.dart';
import '../../domain/usecase/get_hotel_by_id_usecase.dart';
import '../../domain/usecase/hotel_reservation/add_hotel_usecase.dart';
import '../../domain/usecase/hotel_reservation/delete_hotel_usecase.dart';
import '../../domain/usecase/hotel_reservation/get_hotel_usecase.dart';
import '../../domain/usecase/hotel_reservation/update_hotel_usecase.dart';
import '../../domain/usecase/ordering_by_fields.dart';
import '../../domain/usecase/rateUsecases/get_all_hotel_rate_usecase.dart';
import '../../domain/usecase/rateUsecases/get_hotel_rate_by_id_usecase.dart';
import '../../domain/usecase/rateUsecases/get_hotel_rate_by_user_usecase.dart';
import '../../domain/usecase/rateUsecases/update_or_create_hotel_rate.dart';
import '../../domain/usecase/search_by_fields_usecase.dart';
import '../../domain/usecase/search_by_rate_usecase.dart';
import '../../domain/usecase/update_hotel_usecase.dart';
import 'hotels_event.dart';
import 'hotels_state.dart';

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  final GetHotelUsecase getHotelUsecase;
  final GetHotelByIdUsecase getHotelByIdUsecase;
  final AddHotelUsecase addHotelUsecase;
  final UpdateHotelUsecase updateHotelUsecase;
  final DeleteHotelUsecase deleteHotelUsecase;
  final OrderingHotelByFieldsUsecase orderingHotelByFieldsUsecase;
  final SearchByFieldsHotelUsecase searchHotelByFieldsUsecase;
  final SearchHotelByRateUsecase searchHotelByRateUsecase;
  final GetHotelRateUsecase getHotelRateUsecase;
  final GetHotelRateByIdUsecase getHotelRateByIdUsecase;
  final UpdateCreateHotelRateUsecase updateCreateHotelRateUsecase;
  final GetHotelRateByUserUsecase getHotelRateByUserUsecase;

  final UpdateCreateHotelFavoriteUsecase updateCreateHotelFavoriteUsecase;
  final GetHotelFavoriteUsecase getHotelFavoriteUsecase;

  // HotelReservation
  final GetHotelReservationUsecase getHotelReservationUsecase;
  final GetHotelReservationByUserUsecase getHotelReservationByUserUsecase;
  final AddHotelReservationUsecase addHotelReservationUsecase;
  final UpdateHotelReservationUsecase updateHotelReservationUsecase;
  final DeleteHotelReservationUsecase deleteHotelReservationUsecase;

  HotelsBloc(
    this.getHotelUsecase,
    this.getHotelByIdUsecase,
    this.addHotelUsecase,
    this.updateHotelUsecase,
    this.deleteHotelUsecase,
    this.orderingHotelByFieldsUsecase,
    this.searchHotelByFieldsUsecase,
    this.searchHotelByRateUsecase,
    this.getHotelRateUsecase,
    this.getHotelRateByIdUsecase,
    this.updateCreateHotelRateUsecase,
    this.getHotelRateByUserUsecase,
    this.updateCreateHotelFavoriteUsecase,
    this.getHotelFavoriteUsecase,
    this.getHotelReservationUsecase,
    this.getHotelReservationByUserUsecase,
    this.addHotelReservationUsecase,
    this.updateHotelReservationUsecase,
    this.deleteHotelReservationUsecase,
  ) : super(HotelsState()) {
    on<GetHotelsEvent>(_getHotels);
    on<GetHotelsByIdEvent>(_getHotelsById);

    on<AddHotelEvent>(_addHotel);
    on<UpdateHotelEvent>(_updateHotel);
    on<DeleteHotelEvent>(_deleteHotel);
    on<OrderingHotelByFieldsEvent>(_orderingHotelByFields);
    on<SearchHotelByFieldsEvent>(_searchHotelByFields);
    on<SearchHotelByRateEvent>(_searchHotelByRate);
    on<GetHotelRatesEvent>(_getHotelRates);
    on<GetHotelRateByIdEvent>(_getHotelRateById);
    on<UpdateCreateHotelRatesEvent>(_updateCreateHotelRates);
    on<GetHotelRateByUserEvent>(_getHotelRateByUserRates);

    on<UpdateCreateHotelFavoriteEvent>(_updateCreateHotelFavorite);
    on<GetHotelFavoriteEvent>(_getHotelFavorite);

    // HotelReservation
    on<GetHotelsReservationEvent>(_getHotelsReservation);
    on<GetHotelsReservationByUserEvent>(_getHotelsReservationByUser);
    on<AddHotelReservationEvent>(_addHotelReservation);
    on<UpdateHotelReservationEvent>(_updateHotelReservation);
    on<DeleteHotelReservationEvent>(_deleteHotelReservation);
  }

  FutureOr<void> _getHotels(
      GetHotelsEvent event, Emitter<HotelsState> emit) async {
    (await getHotelUsecase(const NoParameters())).fold((l) {
      return emit(
          HotelsState(hotelState: RequestState.error, hotelMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        hotels: r,
        hotelState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _getHotelsById(
      GetHotelsByIdEvent event, Emitter<HotelsState> emit) async {
    (await getHotelByIdUsecase(event.hotelsId)).fold((l) {
      return emit(HotelsState(
          hotelStateById: RequestState.error, hotelMessageById: l.message));
    }, (r) {
      return emit(HotelsState(
        hotelsById: r,
        hotelStateById: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _addHotel(
      AddHotelEvent event, Emitter<HotelsState> emit) async {
    (await addHotelUsecase(event.hotel)).fold((l) {
      return emit(HotelsState(
          addHotelState: RequestState.error, addHotelMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        addHotelState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _updateHotel(
      UpdateHotelEvent event, Emitter<HotelsState> emit) async {
    (await updateHotelUsecase(event.hotel)).fold((l) {
      return emit(HotelsState(
          updateHotelState: RequestState.error, updateHotelMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        updateHotelState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _deleteHotel(
      DeleteHotelEvent event, Emitter<HotelsState> emit) async {
    (await deleteHotelUsecase(event.hotelsId)).fold((l) {
      return emit(HotelsState(
          deleteHotelState: RequestState.error, deleteHotelMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        deleteHotelState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _searchHotelByFields(
      SearchHotelByFieldsEvent event, Emitter<HotelsState> emit) async {
    (await searchHotelByFieldsUsecase(event.hotelSearchByFeild)).fold((l) {
      return emit(HotelsState(
          searchHotelState: RequestState.error,
          searchHotelsMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        searchHotels: r,
        searchHotelState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _searchHotelByRate(
      SearchHotelByRateEvent event, Emitter<HotelsState> emit) async {
    (await searchHotelByRateUsecase(const NoParameters())).fold((l) {
      return emit(HotelsState(
          searchHotelRateState: RequestState.error,
          searchHotelRateMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        searchHotelRate: r,
        searchHotelRateState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _orderingHotelByFields(
      OrderingHotelByFieldsEvent event, Emitter<HotelsState> emit) async {
    (await orderingHotelByFieldsUsecase(event.hotelOrderingByFeild)).fold((l) {
      return emit(HotelsState(
          orderingHotelState: RequestState.error,
          orderingHotelMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        orderingHotelState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _getHotelRates(
      GetHotelRatesEvent event, Emitter<HotelsState> emit) async {
    (await getHotelRateUsecase(const NoParameters())).fold((l) {
      return emit(HotelsState(
          getHotelRateState: RequestState.error,
          getHotelRateMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        getHotelRate: r,
        getHotelRateState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _getHotelRateById(
      GetHotelRateByIdEvent event, Emitter<HotelsState> emit) async {
    (await getHotelRateByIdUsecase(event.hotelRateId)).fold((l) {
      return emit(HotelsState(
          getHotelRateByIdState: RequestState.error,
          getHotelRateByIdMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        getHotelRateById: r,
        getHotelRateByIdState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _updateCreateHotelRates(
      UpdateCreateHotelRatesEvent event, Emitter<HotelsState> emit) async {
    (await updateCreateHotelRateUsecase(
            event.updateCreateHotelRate, event.hotelID))
        .fold((l) {
      return emit(HotelsState(
          updateCreateHotelRateState: RequestState.error,
          updateCreateHotelRateMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        updateCreateHotelRateState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _getHotelRateByUserRates(
      GetHotelRateByUserEvent event, Emitter<HotelsState> emit) async {
    (await getHotelRateByUserUsecase(event.hotelId, event.userId)).fold((l) {
      return emit(HotelsState(
          getHotelRateByUserState: RequestState.error,
          getHotelRateByUserMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        getHotelRateByUser: r,
        getHotelRateByUserState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _updateCreateHotelFavorite(
      UpdateCreateHotelFavoriteEvent event, Emitter<HotelsState> emit) async {
    (await updateCreateHotelFavoriteUsecase(
      event.updateCreateHotelFavorite,
    ))
        .fold((l) {
      return emit(HotelsState(
          updateCreateHotelFavoriteState: RequestState.error,
          updateCreateHotelFavoriteMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        updateCreateHotelFavoriteState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _getHotelFavorite(
      GetHotelFavoriteEvent event, Emitter<HotelsState> emit) async {
    (await getHotelFavoriteUsecase(event.getHotelFavorite)).fold((l) {
      return emit(HotelsState(
          getHotelFavoriteState: RequestState.error,
          getHotelFavoriteMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        getHotelFavorite: r,
        getHotelFavoriteState: RequestState.loaded,
      ));
    });
  }

  // HotelReservation
  FutureOr<void> _getHotelsReservation(
      GetHotelsReservationEvent event, Emitter<HotelsState> emit) async {
    (await getHotelReservationUsecase(event.hotelId)).fold((l) {
      return emit(HotelsState(
          hotelReservationState: RequestState.error,
          hotelReservationMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        hotelsReservation: r,
        hotelReservationState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _getHotelsReservationByUser(
      GetHotelsReservationByUserEvent event, Emitter<HotelsState> emit) async {
    (await getHotelReservationByUserUsecase(event.userId)).fold((l) {
      return emit(HotelsState(
          hotelReservationByUserState: RequestState.error,
          hotelReservationByUserMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        hotelsReservationByUser: r,
        hotelReservationByUserState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _addHotelReservation(
      AddHotelReservationEvent event, Emitter<HotelsState> emit) async {
    (await addHotelReservationUsecase(event.hotelReservation)).fold((l) {
      return emit(HotelsState(
          addHotelReservationState: RequestState.error,
          addHotelReservationMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        addHotelReservationState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _updateHotelReservation(
      UpdateHotelReservationEvent event, Emitter<HotelsState> emit) async {
    (await updateHotelReservationUsecase(event.hotelReservation)).fold((l) {
      return emit(HotelsState(
          updateHotelReservationState: RequestState.error,
          updateHotelReservationMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        updateHotelReservationState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _deleteHotelReservation(
      DeleteHotelReservationEvent event, Emitter<HotelsState> emit) async {
    (await deleteHotelReservationUsecase(event.hotelsId)).fold((l) {
      return emit(HotelsState(
          deleteHotelReservationState: RequestState.error,
          deleteHotelReservationMessage: l.message));
    }, (r) {
      return emit(HotelsState(
        deleteHotelReservationState: RequestState.loaded,
      ));
    });
  }
}
