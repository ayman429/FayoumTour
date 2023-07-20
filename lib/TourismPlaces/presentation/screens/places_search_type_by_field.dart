import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constance/strings_manager.dart';
import '../../../core/utils/enums.dart';
import '../../../home/home_card_of_tourism_hotel.dart';
import '../controller/tourism_place_bloc.dart';
import '../controller/tourism_place_event.dart';
import '../controller/tourism_place_state.dart';

class HomeCardsTourismPlacesTypeSearch extends StatelessWidget {
  String tourismPlaceSearchByFeild; //"Pharaonic relics"
  HomeCardsTourismPlacesTypeSearch({
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
                    tourismPlaceSearchByFeild,
                    style: const TextStyle(
                      fontFamily: "alata",
                      fontSize: 18),
                  ),
                  Row(
                    children: const [
                      Text(
                        AppStrings.seeMore,
                        style: TextStyle(
                          fontFamily: "alata",
                          fontSize: 18),
                      ),
                      Icon(Icons.arrow_right)
                    ],
                  ),
                ],
              )),
          BlocBuilder<TourismPlaceBloc, TourismPlaceState>(
              builder: (context, state) {
            switch (state.searchTourismPlaceState) {
              case RequestState.loading:
                return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()));
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
                      return HomeCard(
                        data: searchTourismPlace,
                        index: 0,
                        type: "places",
                      );
                    },
                  ),
                );
              case RequestState.error:
                return const Center(child: Text("Error"));
            }
          })
        ]));
  }
}
