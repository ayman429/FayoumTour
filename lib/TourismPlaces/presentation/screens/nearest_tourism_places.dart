import 'dart:math';

import 'package:fayoumtour/TourismPlaces/data/models/tourism_place_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';
import '../../../home/search_body.dart';
import '../controller/tourism_place_bloc.dart';
import '../controller/tourism_place_event.dart';
import '../controller/tourism_place_state.dart';

// List<int> listId = [];

class NearestTourismPlaces extends StatelessWidget {
  double lat, lon;
  NearestTourismPlaces({super.key, required this.lat, required this.lon});

  double getDistance(Map<String, dynamic> point) {
    double x1 = lat;
    double y1 = lon;
    double x2 = point['coordinatesX'];
    double y2 = point['coordinatesY'];
    double distance = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
    return distance;
  }

  List<Map<String, dynamic>> rearrangeList(List<Map<String, dynamic>> list) {
    List<Map<String, dynamic>> sortedList =
        List<Map<String, dynamic>>.from(list);
    sortedList.sort((a, b) => getDistance(a).compareTo(getDistance(b)));
    return sortedList;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
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
          return ListView.builder(
            itemCount: sortedArr.length,
            itemBuilder: (context, indexdata) {
              for (var element in state.tourismPlace) {
                ratePlaceMap.addAll({element.id: element.rate_value ?? 0});
              }
              for (var element in state.tourismPlace) {
                favPlaceMap.addAll({element.id: element.fav_value ?? 0});
              }
              return SeachBody(
                data: data[indexdata],
                type: "places",
              );
            },
          );

        case RequestState.error:
          BlocProvider.of<TourismPlaceBloc>(context)
              .add(GetTourismPlaceEvent());
          return const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()));
      }
    }));
  }
}
