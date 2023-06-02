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



class TopRatedTourismPlaces extends StatelessWidget {
  const TopRatedTourismPlaces({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.topRatedTourismPlaces,
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
      BlocProvider(create: (context) {
        return getIt<TourismPlaceBloc>()..add(SearchTourismPlaceByRateEvent());
      }, child: BlocBuilder<TourismPlaceBloc, TourismPlaceState>(
          builder: (context, state) {
        switch (state.searchTourismPlaceRateState) {
          case RequestState.loading:
            return const SizedBox(
                height: 200, child: Center(child: CircularProgressIndicator()));
          case RequestState.loaded:
            print("loaded");
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.builder(
                itemCount: state.searchTourismPlaceRate.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final searchTourismPlaceRate =
                      state.searchTourismPlaceRate[index];
                  return HomeCard(
                    data: searchTourismPlaceRate,
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
