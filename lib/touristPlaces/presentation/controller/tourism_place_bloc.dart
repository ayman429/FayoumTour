import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/enums.dart';
import '../../domain/usecase/get_tourism_place_usecase.dart';
import 'tourism_place_event.dart';
import 'tourism_place_state.dart';

class TourismPlaceBloc extends Bloc<TourismPlaceEvent, TourismPlaceState> {
  final GetTourismPlaceUsecase getTourismPlaceUsecase;

  TourismPlaceBloc(this.getTourismPlaceUsecase) : super(TourismPlaceState()) {
    on<GetTourismPlaceEvent>(_getTourismPlace);
  }

  FutureOr<void> _getTourismPlace(
      GetTourismPlaceEvent event, Emitter<TourismPlaceState> emit) async {
    (await getTourismPlaceUsecase(const NoParameters())).fold((l) {
      // print("left");
      // print(l.message);
      return emit(TourismPlaceState(
          tourismPlaceState: RequestState.error, message: l.message));
    }, (r) {
      // print("right");
      // print(r[0].name);
      return emit(TourismPlaceState(
        tourismPlace: r,
        tourismPlaceState: RequestState.loaded,
      ));
    });
  }
}
