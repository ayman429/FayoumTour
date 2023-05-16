import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/enums.dart';
import '../../domain/usecase/get_tourism_place_usecase.dart';
import '../../domain/usecase/search_by_fields_usecase.dart';
import 'tourism_place_event.dart';
import 'tourism_place_state.dart';

class TourismPlaceBloc extends Bloc<TourismPlaceEvent, TourismPlaceState> {
  final GetTourismPlaceUsecase getTourismPlaceUsecase;
  final SearchByFieldsTourismPlaceUsecase searchByFieldsUsecase;

  TourismPlaceBloc(this.getTourismPlaceUsecase, this.searchByFieldsUsecase)
      : super(TourismPlaceState()) {
    on<GetTourismPlaceEvent>(_getTourismPlace);
    on<SearchByFieldsEvent>(_SearchByFields);
  }

  FutureOr<void> _getTourismPlace(
      GetTourismPlaceEvent event, Emitter<TourismPlaceState> emit) async {
    (await getTourismPlaceUsecase(const NoParameters())).fold((l) {
      // print("left");
      // print(l.message);
      return emit(TourismPlaceState(
          tourismPlaceState: RequestState.error,
          tourismPlaceMessage: l.message));
    }, (r) {
      // print("right");
      // print(r[0].name);
      return emit(TourismPlaceState(
        tourismPlace: r,
        tourismPlaceState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _SearchByFields(
      SearchByFieldsEvent event, Emitter<TourismPlaceState> emit) async {
    (await searchByFieldsUsecase(event.tourismPlaceSearchByFeild)).fold((l) {
      // print("left");
      // print(l.message);
      return emit(TourismPlaceState(
          searchTourismPlaceState: RequestState.error,
          searchTourismPlaceMessage: l.message));
    }, (r) {
      // print("right");
      // print(r[0].name);
      return emit(TourismPlaceState(
        searchTourismPlace: r,
        searchTourismPlaceState: RequestState.loaded,
      ));
    });
  }
}
