import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../hotels/domain/usecase/get_hotel_usecase.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/enums.dart';
import 'hotels_event.dart';
import 'hotels_state.dart';

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  final GetHotelUsecase getHotelUsecase;

  HotelsBloc(this.getHotelUsecase) : super(HotelsState()) {
    on<GetHotelsEvent>(_getHotels);
  }

  FutureOr<void> _getHotels(
      GetHotelsEvent event, Emitter<HotelsState> emit) async {
    (await getHotelUsecase(const NoParameters())).fold((l) {
      // print("left");
      // print(l.message);
      return emit(
          HotelsState(hotelState: RequestState.error, message: l.message));
    }, (r) {
      // print("right");
      // print(r[0].name);
      return emit(HotelsState(
        hotels: r,
        hotelState: RequestState.loaded,
      ));
    });
  }
}
