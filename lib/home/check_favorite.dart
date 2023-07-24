import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../TourismPlaces/domain/entities/tourism_place_favorite.dart';
import '../TourismPlaces/presentation/controller/tourism_place_bloc.dart';
import '../TourismPlaces/presentation/controller/tourism_place_event.dart';
import '../TourismPlaces/presentation/controller/tourism_place_state.dart';
import '../core/services/services_locator.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/enums.dart';
import '../hotels/domain/entities/hotel_favorite.dart';
import '../hotels/presentation/controller/hotels_bloc.dart';
import '../hotels/presentation/controller/hotels_event.dart';
import '../hotels/presentation/controller/hotels_state.dart';

class CheckFavorite extends StatelessWidget {
  var fav_value;
  var id;
  int index;
  CheckFavorite({
    Key? key,
    required this.fav_value,
    required this.id,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: index == 0
          ? BlocProvider.value(
              value: getIt<TourismPlaceBloc>(),
              child: BlocConsumer<TourismPlaceBloc, TourismPlaceState>(
                listener: (context, state) {
                  if (state.updateCreateTourismPlaceFavoriteState ==
                      RequestState.loaded) {
                    print("Loded");
                  } else if (state.updateCreateTourismPlaceFavoriteState ==
                      RequestState.loading) {
                    print("Loding");
                  } else if (state.updateCreateTourismPlaceFavoriteState ==
                      RequestState.error) {
                    // SnackBarMessage().showErrorSnackBar(
                    //     message: state.updateCreateTourismPlaceRateMessage,
                    //     context: context);
                  }
                },
                builder: (context, state) {
                  return IconButton(
                    onPressed: () async {
                      TourismPlaceFavorite tourismPlaceFavorite =
                          TourismPlaceFavorite(
                              fav: fav_value == 0 ? 1 : 0,
                              placeId: id,
                              user: int.parse(
                                  sharedPreferences!.getString("USERID") ??
                                      "0"));
                      BlocProvider.of<TourismPlaceBloc>(context)
                          .add(UpdateCreateTourismPlaceFavoriteEvent(
                        updateCreateTourFavorite: tourismPlaceFavorite,
                      ));
                    },
                    icon: (favPlaceMap[id] == 1)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 40,
                          )
                        : const Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.red,
                            size: 40,
                          ),
                  );
                },
              ),
            )
          : BlocProvider.value(
              value: getIt<HotelsBloc>(),
              child: BlocConsumer<HotelsBloc, HotelsState>(
                listener: (context, state) {
                  if (state.updateCreateHotelFavoriteState ==
                      RequestState.loaded) {
                    print("Loded");
                  } else if (state.updateCreateHotelFavoriteState ==
                      RequestState.loading) {
                    print("Loding");
                  } else if (state.updateCreateHotelFavoriteState ==
                      RequestState.error) {
                    // SnackBarMessage().showErrorSnackBar(
                    //     message: state.updateCreateTourismPlaceRateMessage,
                    //     context: context);
                  }
                },
                builder: (context, state) {
                  return IconButton(
                    onPressed: () async {
                      HotelFavorite hotelFav = HotelFavorite(
                          fav: fav_value == 0 ? 1 : 0,
                          hotelId: id,
                          user: int.parse(
                              sharedPreferences!.getString("USERID") ?? "0"));
                      BlocProvider.of<HotelsBloc>(context).add(
                          UpdateCreateHotelFavoriteEvent(
                              updateCreateHotelFavorite: hotelFav));
                    },
                    icon: (favHotelMap[id] == 1)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 40,
                          )
                        : const Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.red,
                            size: 40,
                          ),
                  );
                },
              ),
            ),
    );
  }
}
