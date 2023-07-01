import 'package:fayoumtour/TourismPlaces/presentation/controller/tourism_place_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/enums.dart';
import '../../../home/StarsRating.dart';
import '../controller/tourism_place_bloc.dart';
import '../controller/tourism_place_event.dart';

class GetRatingPLaces extends StatelessWidget {
  int placeId;
  GetRatingPLaces({
    Key? key,
    required this.placeId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("---------->");
    print(placeId);
    return BlocProvider(create: (context) {
      return getIt<TourismPlaceBloc>();
    }, child: BlocBuilder<TourismPlaceBloc, TourismPlaceState>(
        builder: (context, state) {
      BlocProvider.of<TourismPlaceBloc>(context).add(
          GetTourismPlaceRateByUserEvent(
              placeId: placeId,
              userId:
                  int.parse(sharedPreferences!.getString("USERID") ?? "0")));
      print(state.getTourismPlaceRateByUserState);
      print(placeId);
      switch (state.getTourismPlaceRateByUserState) {
        case RequestState.loading:
          return const SizedBox(
              height: 30, child: Center(child: CircularProgressIndicator()));
        case RequestState.loaded:
          print(state.getTourismPlaceRateByUser);
          return RatingScreen(
            type: "places",
            data: state.getTourismPlaceRateByUser,
            id: placeId,
          );
        case RequestState.error:
          return const Center(child: Text("Error"));
      }
    }));
  }
}
