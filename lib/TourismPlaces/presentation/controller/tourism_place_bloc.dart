import 'dart:async';

import 'package:fayoumtour/TourismPlaces/domain/usecase/rateUsecases/get_place_rate_by_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/enums.dart';
import '../../domain/usecase/add_tourism_place_usecase.dart';
import '../../domain/usecase/delete_tourism_place_usecase.dart';
import '../../domain/usecase/favorite/get_place_favorite_usecase.dart';
import '../../domain/usecase/favorite/update_or_create_tourism_place_favorite_usecase.dart';
import '../../domain/usecase/get_tourism_place_by_id_usecase.dart';
import '../../domain/usecase/get_tourism_place_usecase.dart';
import '../../domain/usecase/model1_usecase.dart';
import '../../domain/usecase/ordering_by_fields.dart';
import '../../domain/usecase/rateUsecases/get_all_tourism_place_rate_usecase.dart';
import '../../domain/usecase/rateUsecases/get_tourism_place_rate_by_id_usecase.dart';
import '../../domain/usecase/rateUsecases/update_or_create_tourism_place_rate.dart';
import '../../domain/usecase/search_by_fields_usecase.dart';
import '../../domain/usecase/search_by_rate_usecase.dart';
import '../../domain/usecase/update_tourism_place_usecase.dart';
import 'tourism_place_event.dart';
import 'tourism_place_state.dart';

Map<int, int> ratePlaceMap = {};
Map<int, int> favPlaceMap = {};

class TourismPlaceBloc extends Bloc<TourismPlaceEvent, TourismPlaceState> {
  final GetTourismPlaceUsecase getTourismPlaceUsecase;
  final GetTourismPlaceByIdUsecase getTourismPlaceByIdUsecase;
  final AddTourismPlaceUsecase addTourismPlaceUsecase;
  final UpdateTourismPlaceUsecase updateTourismPlaceUsecase;
  final DeleteTourismPlaceUsecase deleteTourismPlaceUsecase;
  final OrderingTourismPlaceByFieldsUsecase orderingByFieldsUsecase;
  final SearchByFieldsTourismPlaceUsecase searchByFieldsUsecase;
  final Model1Usecase model1Usecase;
  final SearchTourismPlaceByRateUsecase searchTourismPlaceByRateUsecase;
  final GetTourismPlaceRateUsecase getTourismPlaceRateUsecase;
  final GetTourismPlaceRateByIdUsecase getTourismPlaceRateByIdUsecase;
  final UpdateCreateTourismPlaceRateUsecase updateCreateTourismPlaceRateUsecase;
  final GetTourismPlaceRateByUserUsecase getTourismPlaceRateByUserUsecase;

  final UpdateCreateTourismPlaceFavoriteUsecase
      updateCreateTourismPlaceFavoriteUsecase;
  final GetTourismPlaceFavoriteUsecase getTourismPlaceFavoriteUsecase;

  TourismPlaceBloc(
      this.getTourismPlaceUsecase,
      this.getTourismPlaceByIdUsecase,
      this.addTourismPlaceUsecase,
      this.updateTourismPlaceUsecase,
      this.deleteTourismPlaceUsecase,
      this.orderingByFieldsUsecase,
      this.searchByFieldsUsecase,
      this.model1Usecase,
      this.searchTourismPlaceByRateUsecase,
      this.getTourismPlaceRateUsecase,
      this.getTourismPlaceRateByIdUsecase,
      this.updateCreateTourismPlaceRateUsecase,
      this.getTourismPlaceRateByUserUsecase,
      this.getTourismPlaceFavoriteUsecase,
      this.updateCreateTourismPlaceFavoriteUsecase)
      : super(TourismPlaceState()) {
    on<GetTourismPlaceEvent>(_getTourismPlace);
    on<GetTourismPlacesByIdEvent>(_getTourismPlaceById);
    on<AddTourismPlaceEvent>(_addTourismPlace);
    on<UpdateTourismPlaceEvent>(_updateTourismPlace);
    on<DeleteTourismPlaceEvent>(_deleteTourismPlace);
    on<OrderingTourismPlaceByFieldsEvent>(_orderingByFields);
    on<SearchTourismPlaceByFieldsEvent>(_searchByFields);
    on<Model1Event>(_model1);
    on<SearchTourismPlaceByRateEvent>(_searchByRate);
    on<GetTourismPlaceRatesEvent>(_getTourismPlaceRates);
    on<GetTourismPlaceRateByIdEvent>(_getTourismPlaceRateById);
    on<UpdateCreateTourismPlaceRatesEvent>(_updateCreateTourismPlaceRates);
    on<GetTourismPlaceRateByUserEvent>(_getTourismPlaceRateByUserRates);

    on<UpdateCreateTourismPlaceFavoriteEvent>(
        _updateCreateTourismPlaceFavorite);
    on<GetTourismPlaceFavoriteEvent>(_getTourismPlaceFavorite);
  }

  FutureOr<void> _getTourismPlace(
      GetTourismPlaceEvent event, Emitter<TourismPlaceState> emit) async {
    try {
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
    } catch (e) {
      emit(TourismPlaceState(
          tourismPlaceState: RequestState.error,
          tourismPlaceMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _getTourismPlaceById(
      GetTourismPlacesByIdEvent event, Emitter<TourismPlaceState> emit) async {
    try {
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
    } catch (e) {
      emit(TourismPlaceState(
          tourismPlaceStateById: RequestState.error,
          tourismPlaceMessageById: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _addTourismPlace(
      AddTourismPlaceEvent event, Emitter<TourismPlaceState> emit) async {
    try {
      (await addTourismPlaceUsecase(event.tourismPlace)).fold((l) {
        return emit(TourismPlaceState(
            addTourismPlaceState: RequestState.error,
            addTourismPlaceMessage: l.message));
      }, (r) {
        return emit(TourismPlaceState(
          addTourismPlaceState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(TourismPlaceState(
          addTourismPlaceState: RequestState.error,
          addTourismPlaceMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _updateTourismPlace(
      UpdateTourismPlaceEvent event, Emitter<TourismPlaceState> emit) async {
    try {
      (await updateTourismPlaceUsecase(event.tourismPlace)).fold((l) {
        return emit(TourismPlaceState(
            searchTourismPlaceState: RequestState.error,
            updateTourismPlaceMessage: l.message));
      }, (r) {
        return emit(TourismPlaceState(
          updateTourismPlaceState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(TourismPlaceState(
          searchTourismPlaceState: RequestState.error,
          updateTourismPlaceMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _deleteTourismPlace(
      DeleteTourismPlaceEvent event, Emitter<TourismPlaceState> emit) async {
    try {
      (await deleteTourismPlaceUsecase(event.tourId)).fold((l) {
        return emit(TourismPlaceState(
            deleteTourismPlaceState: RequestState.error,
            deleteTourismPlaceMessage: l.message));
      }, (r) {
        return emit(TourismPlaceState(
          deleteTourismPlaceState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(TourismPlaceState(
          deleteTourismPlaceState: RequestState.error,
          deleteTourismPlaceMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _searchByFields(SearchTourismPlaceByFieldsEvent event,
      Emitter<TourismPlaceState> emit) async {
    // emit(TourismPlaceState(searchTourismPlaceState: RequestState.loading));
    // print("===================>");
    try {
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
    } catch (e) {
      emit(TourismPlaceState(
          searchTourismPlaceState: RequestState.error,
          searchTourismPlaceMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _model1(
      Model1Event event, Emitter<TourismPlaceState> emit) async {
    try {
      (await model1Usecase(event.model1Input)).fold((l) {
        return emit(TourismPlaceState(
            model1State: RequestState.error, model1Message: l.message));
      }, (r) {
        return emit(TourismPlaceState(
          model1: r,
          model1State: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(TourismPlaceState(
          model1State: RequestState.error,
          model1Message: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _searchByRate(SearchTourismPlaceByRateEvent event,
      Emitter<TourismPlaceState> emit) async {
    try {
      (await searchTourismPlaceByRateUsecase(const NoParameters())).fold((l) {
        return emit(TourismPlaceState(
            searchTourismPlaceRateState: RequestState.error,
            searchTourismPlaceRateMessage: l.message));
      }, (r) {
        return emit(TourismPlaceState(
          searchTourismPlaceRate: r,
          searchTourismPlaceRateState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(TourismPlaceState(
          searchTourismPlaceRateState: RequestState.error,
          searchTourismPlaceRateMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _orderingByFields(OrderingTourismPlaceByFieldsEvent event,
      Emitter<TourismPlaceState> emit) async {
    try {
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
    } catch (e) {
      emit(TourismPlaceState(
          orderingTourismPlaceState: RequestState.error,
          orderingTourismPlaceMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _getTourismPlaceRates(
      GetTourismPlaceRatesEvent event, Emitter<TourismPlaceState> emit) async {
    try {
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
    } catch (e) {
      emit(TourismPlaceState(
          getTourismPlaceRateState: RequestState.error,
          getTourismPlaceRateMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _getTourismPlaceRateById(GetTourismPlaceRateByIdEvent event,
      Emitter<TourismPlaceState> emit) async {
    try {
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
    } catch (e) {
      emit(TourismPlaceState(
          getTourismPlaceRateByIdState: RequestState.error,
          getTourismPlaceRateByIdMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _updateCreateTourismPlaceRates(
      UpdateCreateTourismPlaceRatesEvent event,
      Emitter<TourismPlaceState> emit) async {
    print("value===");
    print(event.updateCreateTourRate.stars);
    int tourismPlaceID = int.parse(event.tourismPlaceID);
    ratePlaceMap[tourismPlaceID] = event.updateCreateTourRate.stars;
    emit(TourismPlaceState(
      updateCreateTourismPlaceRateState: RequestState.loaded,
    ));
    try {
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
    } catch (e) {
      emit(TourismPlaceState(
          updateCreateTourismPlaceRateState: RequestState.error,
          updateCreateTourismPlaceRateMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _getTourismPlaceRateByUserRates(
      GetTourismPlaceRateByUserEvent event,
      Emitter<TourismPlaceState> emit) async {
    try {
      (await getTourismPlaceRateByUserUsecase(event.placeId, event.userId))
          .fold((l) {
        return emit(TourismPlaceState(
            getTourismPlaceRateByUserState: RequestState.error,
            getTourismPlaceRateByUserMessage: l.message));
      }, (r) {
        return emit(TourismPlaceState(
          getTourismPlaceRateByUser: r,
          getTourismPlaceRateByUserState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(TourismPlaceState(
          getTourismPlaceRateByUserState: RequestState.error,
          getTourismPlaceRateByUserMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _updateCreateTourismPlaceFavorite(
      UpdateCreateTourismPlaceFavoriteEvent event,
      Emitter<TourismPlaceState> emit) async {
    int? placeId = event.updateCreateTourFavorite.placeId;
    favPlaceMap[placeId ?? 0] = favPlaceMap[placeId] == 0 ? 1 : 0;
    emit(TourismPlaceState(
      updateCreateTourismPlaceFavoriteState: RequestState.loaded,
    ));
    try {
      (await updateCreateTourismPlaceFavoriteUsecase(
        event.updateCreateTourFavorite,
      ))
          .fold((l) {
        return emit(TourismPlaceState(
            updateCreateTourismPlaceFavoriteState: RequestState.error,
            updateCreateTourismPlaceFavoriteMessage: l.message));
      }, (r) {
        // print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
        // print(favPlaceMap[placeId]);
        // print(event.updateCreateTourFavorite.fav);
        // print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
        return emit(TourismPlaceState(
          updateCreateTourismPlaceFavoriteState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(TourismPlaceState(
          updateCreateTourismPlaceFavoriteState: RequestState.error,
          updateCreateTourismPlaceFavoriteMessage: "Have Problem Try Again"));
    }
  }

  FutureOr<void> _getTourismPlaceFavorite(GetTourismPlaceFavoriteEvent event,
      Emitter<TourismPlaceState> emit) async {
    try {
      (await getTourismPlaceFavoriteUsecase(const NoParameters())).fold((l) {
        return emit(TourismPlaceState(
            getTourismPlaceFavoriteState: RequestState.error,
            getTourismPlaceFavoriteMessage: l.message));
      }, (r) {
        return emit(TourismPlaceState(
          getTourismPlaceFavorite: r,
          getTourismPlaceFavoriteState: RequestState.loaded,
        ));
      });
    } catch (e) {
      emit(TourismPlaceState(
          getTourismPlaceFavoriteState: RequestState.error,
          getTourismPlaceFavoriteMessage: "Have Problem Try Again"));
    }
  }
}
