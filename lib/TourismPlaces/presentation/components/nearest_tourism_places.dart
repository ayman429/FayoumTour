import 'dart:math';

import 'package:fayoumtour/TourismPlaces/data/models/tourism_place_model.dart';
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

Map<String, dynamic> location = {
  "coordinatesX": 20.545655,
  "coordinatesY": 30.545406,
};

double getDistance(Map<String, dynamic> point) {
  double x1 = location['coordinatesX'];
  double y1 = location['coordinatesY'];
  double x2 = point['coordinatesX'];
  double y2 = point['coordinatesY'];
  double distance = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
  return distance;
}

List<Map<String, dynamic>> rearrangeList(List<Map<String, dynamic>> list) {
  List<Map<String, dynamic>> sortedList = List<Map<String, dynamic>>.from(list);
  sortedList.sort((a, b) => getDistance(a).compareTo(getDistance(b)));
  return sortedList;
}

// List<int> listId = [];

class NearestTourismPlaces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nearest",
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
        return getIt<TourismPlaceBloc>()..add(GetTourismPlaceEvent());
      }, child: BlocBuilder<TourismPlaceBloc, TourismPlaceState>(
          builder: (context, state) {
        switch (state.tourismPlaceState) {
          case RequestState.loading:
            return const SizedBox(
                height: 200, child: Center(child: CircularProgressIndicator()));
          case RequestState.loaded:
            // print("-------------------------------------------------------");
            // print(state.tourismPlace.length);
            List<Map<String, dynamic>> arr = [];
            for (int i = 0; i < state.tourismPlace.length; i++) {
              arr.add(state.tourismPlace[i].toJson());
            }
            List<Map<String, dynamic>> sortedArr = [];
            sortedArr = rearrangeList(arr);
            // print(getDistance(sortedArr[0]));
            // print(sortedArr[0]['id']);
            // listId.add(sortedArr[0]['id']);
            var data = List<TourismPlaceModel>.from(
                sortedArr.map((e) => TourismPlaceModel.fromJson(e)));
            // print("-------------------------------------------------------");
            // print(data[0].name);
            // print(arr.length);
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: ListView.builder(
                  itemCount: sortedArr.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, indexdata) {
                    return HomeCard(
                      data: data[indexdata],
                      index: 0,
                      type: "places",
                    );
                  },
                ));

          case RequestState.error:
            return const Center(child: Text("Error"));
        }
      })),
    ]);
  }
}
