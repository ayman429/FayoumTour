import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constance/strings_manager.dart';
import '../../../core/utils/enums.dart';
import '../../../home/home_card_of_tourism_hotel.dart';
import '../controller/tourism_place_bloc.dart';
import '../controller/tourism_place_event.dart';
import '../controller/tourism_place_state.dart';

class HomeCardsTourismPlacesSearch extends StatelessWidget {
  String tourismPlaceSearchByFeild; //"Pharaonic relics"
  HomeCardsTourismPlacesSearch({
    Key? key,
    required this.tourismPlaceSearchByFeild,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return getIt<TourismPlaceBloc>()
            ..add(SearchByFieldsEvent(
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
                    style: GoogleFonts.alata(fontSize: 18),
                  ),
                  Row(
                    children: [
                      Text(
                        AppStrings.seeMore,
                        style: GoogleFonts.alata(fontSize: 18),
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
                      return HomeCard(
                        data: searchTourismPlace,
                        index: 0,
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
