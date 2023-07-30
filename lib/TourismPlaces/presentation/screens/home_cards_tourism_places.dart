import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:google_fonts/google_fonts.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/enums.dart';
import '../../../home/home_card_of_tourism_hotel.dart';
import '../controller/tourism_place_bloc.dart';
import '../controller/tourism_place_event.dart';
import '../controller/tourism_place_state.dart';

class HomeCardsTourismPlaces extends StatelessWidget {
  const HomeCardsTourismPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.translate("Torism Places"),
                style: sharedPreferences!.getString("Language") == "AR"
                ? const TextStyle(fontFamily: "dg", fontSize: 18)
                : const TextStyle(fontFamily: "alata", fontSize: 18),
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.translate("See More"),
                    style: sharedPreferences!.getString("Language") == "AR"
                ? const TextStyle(fontFamily: "dg", fontSize: 18)
                : const TextStyle(fontFamily: "alata", fontSize: 18),
                  ),
                  const Icon(Icons.arrow_right)
                ],
              ),
            ],
          )),
      BlocProvider(create: (context) {
        return getIt<TourismPlaceBloc>()..add(GetTourismPlaceEvent());
      }, child: BlocBuilder<TourismPlaceBloc, TourismPlaceState>(
          builder: (context, state) {
        switch (state.tourismPlaceState) {
          case RequestState.loading:
            return const SizedBox(
                height: 200, child: Center(child: CircularProgressIndicator()));
          case RequestState.loaded:
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.builder(
                itemCount: state.tourismPlace.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final tourismPlace = state.tourismPlace[index];
                  for (var element in state.tourismPlace) {
                    ratePlaceMap.addAll({element.id: element.rate_value ?? 0});
                  }
                  for (var element in state.tourismPlace) {
                    favPlaceMap.addAll({element.id: element.fav_value ?? 0});
                  }
                  return HomeCard(
                    data: tourismPlace,
                    index: 0,
                    type: "places",
                  );
                },
              ),
            );
          case RequestState.error:
            return const Center(child: Text("Error"));
        }
      }))
    ]);
  }
}
