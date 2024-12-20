import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/enums.dart';
import '../../../home/HomeCardsLoading.dart';
import '../../../home/home_card_of_tourism_hotel.dart';
import '../controller/tourism_place_bloc.dart';
import '../controller/tourism_place_event.dart';
import '../controller/tourism_place_state.dart';

class HomeCardsTourismPlacesTypeSearch extends StatelessWidget {
  final String tourismPlaceSearchByFeild; //"Pharaonic relics"
  const HomeCardsTourismPlacesTypeSearch({
    Key? key,
    required this.tourismPlaceSearchByFeild,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return getIt<TourismPlaceBloc>()
            ..add(SearchTourismPlaceByFieldsEvent(
                tourismPlaceSearchByFeild: tourismPlaceSearchByFeild));
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    //tourismPlaceSearchByFeild.trimRight(),
                    AppLocalizations.of(context)!.translate(tourismPlaceSearchByFeild.trimRight()),
                    style: sharedPreferences!.getString("Language") == "AR"
                    ?  TextStyle(fontFamily: "dg", fontSize: (18/360)*MediaQuery.of(context).size.width,//18,
                    )
                    :  TextStyle(fontFamily: "alata", fontSize: (18/360)*MediaQuery.of(context).size.width,//18,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.translate("See More"),
                        style: sharedPreferences!.getString("Language") == "AR"
                    ?  TextStyle(fontFamily: "dg", fontSize: (18/360)*MediaQuery.of(context).size.width,//18,
                    )
                    :  TextStyle(fontFamily: "alata", fontSize: (18/360)*MediaQuery.of(context).size.width,//18,
                    ),
                      ),
                      const Icon(Icons.arrow_right)
                    ],
                  ),
                ],
              )),
          BlocBuilder<TourismPlaceBloc, TourismPlaceState>(
              builder: (context, state) {
            switch (state.searchTourismPlaceState) {
              case RequestState.loading:
                //return const SizedBox(height: 200,child: Center(child: CircularProgressIndicator()));
                return const HomeLoading();
              case RequestState.loaded:
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView.builder(
                    itemCount: state.searchTourismPlace.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final searchTourismPlace =
                          state.searchTourismPlace[index];
                      for (var element in state.tourismPlace) {
                        ratePlaceMap
                            .addAll({element.id: element.rate_value ?? 0});
                      }
                      for (var element in state.tourismPlace) {
                        favPlaceMap
                            .addAll({element.id: element.fav_value ?? 0});
                      }
                      return HomeCard(
                        data: searchTourismPlace,
                        index: 0,
                        type: "places",
                      );
                    },
                  ),
                );
              case RequestState.error:
                BlocProvider.of<TourismPlaceBloc>(context).add(
                    SearchTourismPlaceByFieldsEvent(
                        tourismPlaceSearchByFeild: tourismPlaceSearchByFeild));
                return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()));
            }
          })
        ]));
  }
}
