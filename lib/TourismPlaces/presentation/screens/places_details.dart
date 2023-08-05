import 'package:fayoumtour/TourismPlaces/presentation/controller/tourism_place_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';
import '../../../home/up_bar_image.dart';
import '../controller/tourism_place_bloc.dart';
import '../controller/tourism_place_event.dart';

class PlacesDetails extends StatelessWidget {
  String tourId;
  PlacesDetails({
    Key? key,
    required this.tourId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      return getIt<TourismPlaceBloc>()
        ..add(GetTourismPlacesByIdEvent(tourId: tourId));
    }, child: BlocBuilder<TourismPlaceBloc, TourismPlaceState>(
        builder: (context, state) {
      print(state.tourismPlaceStateById);
      print(tourId);
      switch (state.tourismPlaceStateById) {
        case RequestState.loading:
          return const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()));
        case RequestState.loaded:
          ratePlaceMap[state.tourismPlaceById!.id] =
              state.tourismPlaceById!.rate_value ?? 0;
          favPlaceMap[state.tourismPlaceById!.id] =
              state.tourismPlaceById!.fav_value ?? 0;
          // state.tourismPlace.forEach((element) {
          //         ratePlaceMap.addAll({element.id: element.rate_value ?? 0});
          //       });
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: UpBarImage(
                data: state.tourismPlaceById, index: 0, type: "places"),
          );
        case RequestState.error:
          BlocProvider.of<TourismPlaceBloc>(context)
              .add(GetTourismPlacesByIdEvent(tourId: tourId));
          return const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()));
      }
    }));
  }
}
