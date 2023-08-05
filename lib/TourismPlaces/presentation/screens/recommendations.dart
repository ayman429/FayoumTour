import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/enums.dart';
import '../../../home/home_card_of_tourism_hotel.dart';
import '../controller/tourism_place_bloc.dart';
import '../controller/tourism_place_event.dart';
import '../controller/tourism_place_state.dart';

class recommendations extends StatelessWidget {
  const recommendations({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.translate("Recommendations"),
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
        return getIt<TourismPlaceBloc>()
          ..add(Model1Event(
              model1Input: sharedPreferences!.getString("model1Input") ??
                  "I Love Historical pyramids, I Enjoy water sports"));
      }, child: BlocBuilder<TourismPlaceBloc, TourismPlaceState>(
          builder: (context, state) {
        switch (state.model1State) {
          case RequestState.loading:
            return const SizedBox(
                height: 200, child: Center(child: CircularProgressIndicator()));
          case RequestState.loaded:
            // print("=============>");
            // print(sharedPreferences!.getString("model1Input"));
            // print("loaded");
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.builder(
                itemCount: state.model1.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final model1 = state.model1[index];
                  for (var element in state.tourismPlace) {
                    ratePlaceMap.addAll({element.id: element.rate_value ?? 0});
                  }
                  for (var element in state.tourismPlace) {
                    favPlaceMap.addAll({element.id: element.fav_value ?? 0});
                  }
                  return HomeCard(
                    data: model1,
                    index: 0,
                    type: "places",
                  );
                },
              ),
            );
          case RequestState.error:
            BlocProvider.of<TourismPlaceBloc>(context).add(Model1Event(
                model1Input: sharedPreferences!.getString("model1Input") ??
                    "I Love Historical pyramids, I Enjoy water sports"));
            return const SizedBox(
                height: 200, child: Center(child: CircularProgressIndicator()));
        }
      }))
    ]);
  }
}
