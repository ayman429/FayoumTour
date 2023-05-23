import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../hotels/domain/usecase/get_hotel_usecase.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/enums.dart';
import '../../domain/usecase/add_hotel_usecase.dart';
import '../../domain/usecase/delete_hotel_usecase.dart';
import '../../domain/usecase/get_hotel_by_id_usecase.dart';
import '../../domain/usecase/ordering_by_fields.dart';
import '../../domain/usecase/rateUsecases/get_all_hotel_rate_usecase.dart';
import '../../domain/usecase/rateUsecases/get_hotel_rate_by_id_usecase.dart';
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
      this.updateCreateHotelRateUsecase)
      : super(HotelsState()) {
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
    (await searchHotelByRateUsecase(event.hotelSearchByRate)).fold((l) {
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
}
