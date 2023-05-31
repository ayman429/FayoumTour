import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/enums.dart';
import '../../domain/usecase/add_tourism_place_usecase.dart';
import '../../domain/usecase/delete_tourism_place_usecase.dart';
import '../../domain/usecase/get_tourism_place_by_id_usecase.dart';
import '../../domain/usecase/get_tourism_place_usecase.dart';
import '../../domain/usecase/ordering_by_fields.dart';
import '../../domain/usecase/rateUsecases/get_all_tourism_place_rate_usecase.dart';
import '../../domain/usecase/rateUsecases/get_tourism_place_rate_by_id_usecase.dart';
import '../../domain/usecase/rateUsecases/update_or_create_tourism_place_rate.dart';
import '../../domain/usecase/search_by_fields_usecase.dart';
import '../../domain/usecase/search_by_rate_usecase.dart';
import '../../domain/usecase/update_tourism_place_usecase.dart';
import 'tourism_place_event.dart';
import 'tourism_place_state.dart';

class TourismPlaceBloc extends Bloc<TourismPlaceEvent, TourismPlaceState> {
  final GetTourismPlaceUsecase getTourismPlaceUsecase;
  final GetTourismPlaceByIdUsecase getTourismPlaceByIdUsecase;
  final AddTourismPlaceUsecase addTourismPlaceUsecase;
  final UpdateTourismPlaceUsecase updateTourismPlaceUsecase;
  final DeleteTourismPlaceUsecase deleteTourismPlaceUsecase;
  final OrderingTourismPlaceByFieldsUsecase orderingByFieldsUsecase;
  final SearchByFieldsTourismPlaceUsecase searchByFieldsUsecase;
  final SearchTourismPlaceByRateUsecase searchTourismPlaceByRateUsecase;
  final GetTourismPlaceRateUsecase getTourismPlaceRateUsecase;
  final GetTourismPlaceRateByIdUsecase getTourismPlaceRateByIdUsecase;
  final UpdateCreateTourismPlaceRateUsecase updateCreateTourismPlaceRateUsecase;

  TourismPlaceBloc(
      this.getTourismPlaceUsecase,
      this.getTourismPlaceByIdUsecase,
      this.addTourismPlaceUsecase,
      this.updateTourismPlaceUsecase,
      this.deleteTourismPlaceUsecase,
      this.orderingByFieldsUsecase,
      this.searchByFieldsUsecase,
      this.searchTourismPlaceByRateUsecase,
      this.getTourismPlaceRateUsecase,
      this.getTourismPlaceRateByIdUsecase,
      this.updateCreateTourismPlaceRateUsecase)
      : super(TourismPlaceState()) {
    on<GetTourismPlaceEvent>(_getTourismPlace);
    on<GetTourismPlacesByIdEvent>(_getTourismPlaceById);
    on<AddTourismPlaceEvent>(_addTourismPlace);
    on<UpdateTourismPlaceEvent>(_updateTourismPlace);
    on<DeleteTourismPlaceEvent>(_deleteTourismPlace);
    on<OrderingTourismPlaceByFieldsEvent>(_orderingByFields);
    on<SearchTourismPlaceByFieldsEvent>(_searchByFields);
    on<SearchTourismPlaceByRateEvent>(_searchByRate);
    on<GetTourismPlaceRatesEvent>(_getTourismPlaceRates);
    on<GetTourismPlaceRateByIdEvent>(_getTourismPlaceRateById);
    on<UpdateCreateTourismPlaceRatesEvent>(_updateCreateTourismPlaceRates);
  }

  FutureOr<void> _getTourismPlace(
      GetTourismPlaceEvent event, Emitter<TourismPlaceState> emit) async {
    (await getTourismPlaceUsecase(const NoParameters())).fold((l) {
      return emit(TourismPlaceState(
          tourismPlaceState: RequestState.error,
          tourismPlaceMessage: l.message));
    }, (r) {
      return emit(TourismPlaceState(
        tourismPlace: r,
        tourismPlaceState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _getTourismPlaceById(
      GetTourismPlacesByIdEvent event, Emitter<TourismPlaceState> emit) async {
    (await getTourismPlaceByIdUsecase(event.tourId)).fold((l) {
      return emit(TourismPlaceState(
          tourismPlaceStateById: RequestState.error,
          tourismPlaceMessageById: l.message));
    }, (r) {
      return emit(TourismPlaceState(
        tourismPlaceById: r,
        tourismPlaceStateById: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _addTourismPlace(
      AddTourismPlaceEvent event, Emitter<TourismPlaceState> emit) async {
    (await addTourismPlaceUsecase(event.tourismPlace)).fold((l) {
      return emit(TourismPlaceState(
          addTourismPlaceState: RequestState.error,
          addTourismPlaceMessage: l.message));
    }, (r) {
      return emit(TourismPlaceState(
        addTourismPlaceState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _updateTourismPlace(
      UpdateTourismPlaceEvent event, Emitter<TourismPlaceState> emit) async {
    (await updateTourismPlaceUsecase(event.tourismPlace)).fold((l) {
      return emit(TourismPlaceState(
          searchTourismPlaceState: RequestState.error,
          updateTourismPlaceMessage: l.message));
    }, (r) {
      return emit(TourismPlaceState(
        updateTourismPlaceState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _deleteTourismPlace(
      DeleteTourismPlaceEvent event, Emitter<TourismPlaceState> emit) async {
    (await deleteTourismPlaceUsecase(event.tourId)).fold((l) {
      return emit(TourismPlaceState(
          deleteTourismPlaceState: RequestState.error,
          deleteTourismPlaceMessage: l.message));
    }, (r) {
      return emit(TourismPlaceState(
        deleteTourismPlaceState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _searchByFields(SearchTourismPlaceByFieldsEvent event,
      Emitter<TourismPlaceState> emit) async {
    // emit(TourismPlaceState(searchTourismPlaceState: RequestState.loading));
    // print("===================>");
    (await searchByFieldsUsecase(event.tourismPlaceSearchByFeild)).fold((l) {
      return emit(TourismPlaceState(
          searchTourismPlaceState: RequestState.error,
          searchTourismPlaceMessage: l.message));
    }, (r) {
      return emit(TourismPlaceState(
        searchTourismPlace: r,
        searchTourismPlaceState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _searchByRate(SearchTourismPlaceByRateEvent event,
      Emitter<TourismPlaceState> emit) async {
    (await searchTourismPlaceByRateUsecase(event.tourismPlaceSearchByrate))
        .fold((l) {
      return emit(TourismPlaceState(
          searchTourismPlaceState: RequestState.error,
          searchTourismPlaceMessage: l.message));
    }, (r) {
      return emit(TourismPlaceState(
        searchTourismPlace: r,
        searchTourismPlaceState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _orderingByFields(OrderingTourismPlaceByFieldsEvent event,
      Emitter<TourismPlaceState> emit) async {
    (await orderingByFieldsUsecase(event.tourismPlaceOrderingByFeild)).fold(
        (l) {
      return emit(TourismPlaceState(
          orderingTourismPlaceState: RequestState.error,
          orderingTourismPlaceMessage: l.message));
    }, (r) {
      return emit(TourismPlaceState(
        orderingTourismPlaceState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _getTourismPlaceRates(
      GetTourismPlaceRatesEvent event, Emitter<TourismPlaceState> emit) async {
    (await getTourismPlaceRateUsecase(const NoParameters())).fold((l) {
      return emit(TourismPlaceState(
          getTourismPlaceRateState: RequestState.error,
          getTourismPlaceRateMessage: l.message));
    }, (r) {
      return emit(TourismPlaceState(
        getTourismPlaceRate: r,
        getTourismPlaceRateState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _getTourismPlaceRateById(GetTourismPlaceRateByIdEvent event,
      Emitter<TourismPlaceState> emit) async {
    (await getTourismPlaceRateByIdUsecase(event.tourRateId)).fold((l) {
      return emit(TourismPlaceState(
          getTourismPlaceRateByIdState: RequestState.error,
          getTourismPlaceRateByIdMessage: l.message));
    }, (r) {
      return emit(TourismPlaceState(
        getTourismPlaceRateById: r,
        getTourismPlaceRateByIdState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _updateCreateTourismPlaceRates(
      UpdateCreateTourismPlaceRatesEvent event,
      Emitter<TourismPlaceState> emit) async {
    (await updateCreateTourismPlaceRateUsecase(
            event.updateCreateTourRate, event.tourismPlaceID))
        .fold((l) {
      return emit(TourismPlaceState(
          updateCreateTourismPlaceRateState: RequestState.error,
          updateCreateTourismPlaceRateMessage: l.message));
    }, (r) {
      return emit(TourismPlaceState(
        updateCreateTourismPlaceRateState: RequestState.loaded,
      ));
    });
  }
}
