import 'package:fayoumtour/hotels/presentation/controller/hotels_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constance/strings_manager.dart';
import '../../../core/utils/enums.dart';
import '../../../home/home_card_of_tourism_hotel.dart';
import '../controller/hotels_bloc.dart';
import '../controller/hotels_state.dart';

class TopRatedHotels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.topRatedHotels,
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
        return getIt<HotelsBloc>()..add(SearchHotelByRateEvent());
      }, child: BlocBuilder<HotelsBloc, HotelsState>(builder: (context, state) {
        switch (state.searchHotelRateState) {
          case RequestState.loading:
            return const SizedBox(
                height: 200, child: Center(child: CircularProgressIndicator()));
          case RequestState.loaded:
            print("loaded");
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.builder(
                itemCount: state.searchHotelRate.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final searchHotelRate = state.searchHotelRate[index];
                  return HomeCard(
                    data: searchHotelRate,
                    index: 1,
                    type: "hotels",
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