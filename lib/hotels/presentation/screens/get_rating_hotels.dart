import 'package:fayoumtour/TourismPlaces/presentation/controller/tourism_place_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/enums.dart';
import '../../../home/StarsRating.dart';
import '../controller/hotels_bloc.dart';
import '../controller/hotels_event.dart';
import '../controller/hotels_state.dart';

class GetRatingHotels extends StatelessWidget {
  int hotelId;
  GetRatingHotels({
    Key? key,
    required this.hotelId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("---------->");
    print(hotelId);
    return BlocProvider(create: (context) {
      return getIt<HotelsBloc>();
    }, child: BlocBuilder<HotelsBloc, HotelsState>(builder: (context, state) {
      BlocProvider.of<HotelsBloc>(context).add(GetHotelRateByUserEvent(
          hotelId: hotelId,
          userId: int.parse(sharedPreferences!.getString("USERID") ?? "0")));
      print(state.getHotelRateByUserState);
      print(hotelId);
      switch (state.getHotelRateByUserState) {
        case RequestState.loading:
          return const SizedBox(
              height: 30, child: Center(child: CircularProgressIndicator()));
        case RequestState.loaded:
          print(state.getHotelRateByUser);
          return RatingScreen(
            type: "hotels",
            data: state.getHotelRateByUser,
            id: hotelId,
          );
        case RequestState.error:
          return const Center(child: Text("Error"));
      }
    }));
  }
}
