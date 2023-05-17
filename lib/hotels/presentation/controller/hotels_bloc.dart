import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../hotels/domain/usecase/get_hotel_usecase.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/enums.dart';
import '../../domain/usecase/get_hotel_by_id_usecase.dart';
import '../../domain/usecase/search_by_fields_usecase.dart';
import 'hotels_event.dart';
import 'hotels_state.dart';

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  final GetHotelUsecase getHotelUsecase;
  final GetHotelByIdUsecase getHotelByIdUsecase;
  final SearchByFieldsHotelUsecase searchByFieldsUsecase;
  HotelsBloc(this.getHotelUsecase, this.searchByFieldsUsecase,
      this.getHotelByIdUsecase)
      : super(HotelsState()) {
    on<GetHotelsEvent>(_getHotels);
    on<GetHotelsByIdEvent>(_getHotelsById);
  }

  FutureOr<void> _getHotels(
      GetHotelsEvent event, Emitter<HotelsState> emit) async {
    (await getHotelUsecase(const NoParameters())).fold((l) {
      // print("left");
      // print(l.message);
      return emit(
          HotelsState(hotelState: RequestState.error, hotelMessage: l.message));
    }, (r) {
      // print("right");
      // print(r[0].name);
      return emit(HotelsState(
        hotels: r,
        hotelState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _getHotelsById(
      GetHotelsByIdEvent event, Emitter<HotelsState> emit) async {
    (await getHotelByIdUsecase(event.HotelsId)).fold((l) {
      // print("left");
      // print(l.message);
      return emit(HotelsState(
          hotelStateById: RequestState.error, hotelMessageById: l.message));
    }, (r) {
      // print("right");
      // print(r[0].name);
      return emit(HotelsState(
        hotelsById: r,
        hotelStateById: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _SearchByFields(
      SearchByFieldsEvent event, Emitter<HotelsState> emit) async {
    (await searchByFieldsUsecase(event.hotelSearchByFeild)).fold((l) {
      // print("left");
      // print(l.message);
      return emit(HotelsState(
          searchHotelState: RequestState.error,
          searchHotelsMessage: l.message));
    }, (r) {
      // print("right");
      // print(r[0].name);
      return emit(HotelsState(
        searchHotels: r,
        searchHotelState: RequestState.loaded,
      ));
    });
  }
}
