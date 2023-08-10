import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fayoumtour/hotels/domain/usecase/hotel_reservation/get_hotel_usecase_by_user.dart';

import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/constance/shared_pref.dart';
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
import '../../domain/usecase/hotel_reservation/update_hotel_res_usecase.dart';
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

Map<int, int> rateHotelMap = {};
Map<int, int> favHotelMap = {};

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
  final UpdateHotelReservationByUserUsecase updateHotelReservationByUserUsecase;
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
    this.updateHotelReservationByUserUsecase,
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
    on<UpdateHotelReservationByUserEvent>(_updateHotelReservationByUser);
    on<DeleteHotelReservationEvent>(_deleteHotelReservation);
  }

  FutureOr<void> _getHotels(
      GetHotelsEvent event, Emitter<HotelsState> emit) async {
    try {
      (await getHotelUsecase(const NoParameters())).fold((l) {
        return emit(HotelsState(
            hotelState: RequestState.error, hotelMessage: l.message));
      }, (r) {
        return emit(HotelsState(
          hotels: r,
          hotelState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(HotelsState(
          hotelState: RequestState.error,
          hotelMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _getHotelsById(
      GetHotelsByIdEvent event, Emitter<HotelsState> emit) async {
    try {
      (await getHotelByIdUsecase(event.hotelsId)).fold((l) {
        return emit(HotelsState(
            hotelStateById: RequestState.error, hotelMessageById: l.message));
      }, (r) {
        return emit(HotelsState(
          hotelsById: r,
          hotelStateById: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(HotelsState(
          hotelStateById: RequestState.error,
          hotelMessageById: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _addHotel(
      AddHotelEvent event, Emitter<HotelsState> emit) async {
    try {
      (await addHotelUsecase(event.hotel)).fold((l) {
        return emit(HotelsState(
            addHotelState: RequestState.error, addHotelMessage: l.message));
      }, (r) {
        return emit(HotelsState(
          addHotelState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(HotelsState(
          addHotelState: RequestState.error,
          addHotelMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _updateHotel(
      UpdateHotelEvent event, Emitter<HotelsState> emit) async {
    try {
      (await updateHotelUsecase(event.hotel)).fold((l) {
        return emit(HotelsState(
            updateHotelState: RequestState.error,
            updateHotelMessage: l.message));
      }, (r) {
        return emit(HotelsState(
          updateHotelState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(HotelsState(
          updateHotelState: RequestState.error,
          updateHotelMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _deleteHotel(
      DeleteHotelEvent event, Emitter<HotelsState> emit) async {
    try {
      (await deleteHotelUsecase(event.hotelsId)).fold((l) {
        return emit(HotelsState(
            deleteHotelState: RequestState.error,
            deleteHotelMessage: l.message));
      }, (r) {
        return emit(HotelsState(
          deleteHotelState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(HotelsState(
          deleteHotelState: RequestState.error,
          deleteHotelMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _searchHotelByFields(
      SearchHotelByFieldsEvent event, Emitter<HotelsState> emit) async {
    try {
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
    } catch (e) {
      emit(HotelsState(
          searchHotelState: RequestState.error,
          searchHotelsMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _searchHotelByRate(
      SearchHotelByRateEvent event, Emitter<HotelsState> emit) async {
    try {
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
    } catch (e) {
      emit(HotelsState(
          searchHotelRateState: RequestState.error,
          searchHotelRateMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _orderingHotelByFields(
      OrderingHotelByFieldsEvent event, Emitter<HotelsState> emit) async {
    try {
      (await orderingHotelByFieldsUsecase(event.hotelOrderingByFeild)).fold(
          (l) {
        return emit(HotelsState(
            orderingHotelState: RequestState.error,
            orderingHotelMessage: l.message));
      }, (r) {
        return emit(HotelsState(
          orderingHotelState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(HotelsState(
          orderingHotelState: RequestState.error,
          orderingHotelMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _getHotelRates(
      GetHotelRatesEvent event, Emitter<HotelsState> emit) async {
    try {
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
    } catch (e) {
      emit(HotelsState(
          getHotelRateState: RequestState.error,
          getHotelRateMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _getHotelRateById(
      GetHotelRateByIdEvent event, Emitter<HotelsState> emit) async {
    try {
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
    } catch (e) {
      emit(HotelsState(
          getHotelRateByIdState: RequestState.error,
          getHotelRateByIdMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _updateCreateHotelRates(
      UpdateCreateHotelRatesEvent event, Emitter<HotelsState> emit) async {
    //print("value hotel ===");
    //print(event.updateCreateHotelRate.stars);
    int hotelID = int.parse(event.hotelID);
    rateHotelMap[hotelID] = event.updateCreateHotelRate.stars;
    emit(HotelsState(
      updateCreateHotelRateState: RequestState.loaded,
    ));
    try {
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
    } catch (e) {
      emit(HotelsState(
          updateCreateHotelRateState: RequestState.error,
          updateCreateHotelRateMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _getHotelRateByUserRates(
      GetHotelRateByUserEvent event, Emitter<HotelsState> emit) async {
    try {
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
    } catch (e) {
      emit(HotelsState(
          getHotelRateByUserState: RequestState.error,
          getHotelRateByUserMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _updateCreateHotelFavorite(
      UpdateCreateHotelFavoriteEvent event, Emitter<HotelsState> emit) async {
    int? hotelId = event.updateCreateHotelFavorite.hotelId;
    favHotelMap[hotelId ?? 0] = favHotelMap[hotelId] == 0 ? 1 : 0;
    emit(HotelsState(
      updateCreateHotelFavoriteState: RequestState.loaded,
    ));
    try {
      (await updateCreateHotelFavoriteUsecase(
        event.updateCreateHotelFavorite,
      ))
          .fold((l) {
        return emit(HotelsState(
            updateCreateHotelFavoriteState: RequestState.error,
            updateCreateHotelFavoriteMessage: l.message));
      }, (r) {
        // print("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
        // print(favHotelMap[hotelId]);
        // print("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");

        return emit(HotelsState(
          updateCreateHotelFavoriteState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(HotelsState(
          updateCreateHotelFavoriteState: RequestState.error,
          updateCreateHotelFavoriteMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _getHotelFavorite(
      GetHotelFavoriteEvent event, Emitter<HotelsState> emit) async {
    try {
      (await getHotelFavoriteUsecase(const NoParameters())).fold((l) {
        return emit(HotelsState(
            getHotelFavoriteState: RequestState.error,
            getHotelFavoriteMessage: l.message));
      }, (r) {
        return emit(HotelsState(
          getHotelFavorite: r,
          getHotelFavoriteState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(HotelsState(
          getHotelFavoriteState: RequestState.error,
          getHotelFavoriteMessage: "Have Problem Try Again"));
    }
  }

  // HotelReservation
  FutureOr<void> _getHotelsReservation(
      GetHotelsReservationEvent event, Emitter<HotelsState> emit) async {
    try {
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
    } catch (e) {
      emit(HotelsState(
          hotelReservationState: RequestState.error,
          hotelReservationMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _getHotelsReservationByUser(
      GetHotelsReservationByUserEvent event, Emitter<HotelsState> emit) async {
    try {
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
    } catch (e) {
      emit(HotelsState(
          hotelReservationByUserState: RequestState.error,
          hotelReservationByUserMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _addHotelReservation(
      AddHotelReservationEvent event, Emitter<HotelsState> emit) async {
    try {
      (await addHotelReservationUsecase(event.hotelReservation)).fold((l) {
        return emit(HotelsState(
            addHotelReservationState: RequestState.error,
            addHotelReservationMessage: l.message.toString()));
      }, (r) {
        return emit(HotelsState(
          addHotelReservationState: RequestState.loaded,
        ));
      });
    } catch (e) {
      //print("l.message ${e}");
      return emit(HotelsState(
          addHotelReservationState: RequestState.error,
          addHotelReservationMessage:
              sharedPreferences!.getString("Language") == "AR"
                  ? "لا يوجد انترنت"
                  : "No Connection"));
    }
  }

  FutureOr<void> _updateHotelReservation(
      UpdateHotelReservationEvent event, Emitter<HotelsState> emit) async {
    try {
      (await updateHotelReservationUsecase(event.hotelReservation)).fold((l) {
        return emit(HotelsState(
            updateHotelReservationState: RequestState.error,
            updateHotelReservationMessage: l.message));
      }, (r) {
        return emit(HotelsState(
          updateHotelReservationState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(HotelsState(
          updateHotelReservationState: RequestState.error,
          updateHotelReservationMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _updateHotelReservationByUser(
      UpdateHotelReservationByUserEvent event,
      Emitter<HotelsState> emit) async {
    try {
      (await updateHotelReservationByUserUsecase(
              event.hotelReservation, event.reservationId))
          .fold((l) {
        return emit(HotelsState(
            updateHotelReservationByUserState: RequestState.error,
            updateHotelReservationByUserMessage: l.message));
      }, (r) {
        return emit(HotelsState(
          updateHotelReservationByUserState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(HotelsState(
          updateHotelReservationByUserState: RequestState.error,
          updateHotelReservationByUserMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _deleteHotelReservation(
      DeleteHotelReservationEvent event, Emitter<HotelsState> emit) async {
    try {
      (await deleteHotelReservationUsecase(event.hotelsId)).fold((l) {
        return emit(HotelsState(
            deleteHotelReservationState: RequestState.error,
            deleteHotelReservationMessage: l.message));
      }, (r) {
        return emit(HotelsState(
          deleteHotelReservationState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(HotelsState(
          deleteHotelReservationState: RequestState.error,
          deleteHotelReservationMessage: "Have Problem Try Again"));
    }
  }
}
