import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';
import '../../../home/search_body.dart';
import '../../../hotels/presentation/screens/hotels_search.dart';
import '../controller/tourism_place_bloc.dart';
import '../controller/tourism_place_event.dart';
import '../controller/tourism_place_state.dart';

class TourismPlacesSearch extends StatelessWidget {
  final String textSearchByFeild;

  const TourismPlacesSearch({
    Key? key,
    required this.textSearchByFeild,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      return getIt<TourismPlaceBloc>()
        ..add(SearchTourismPlaceByFieldsEvent(
            tourismPlaceSearchByFeild: textSearchByFeild));
    }, child: BlocBuilder<TourismPlaceBloc, TourismPlaceState>(
        builder: (context, state) {
      BlocProvider.of<TourismPlaceBloc>(context).add(
        SearchTourismPlaceByFieldsEvent(
          tourismPlaceSearchByFeild: textSearchByFeild,
        ),
      );
      switch (state.searchTourismPlaceState) {
        case RequestState.loading:
          return const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()));
        case RequestState.loaded:
          if (state.searchTourismPlace.isNotEmpty) {
            switch (state.searchTourismPlaceState) {
              case RequestState.loading:
                return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()));
              case RequestState.loaded:
                return ListView.builder(
                  itemCount: state.searchTourismPlace.length,
                  itemBuilder: (context, index) {
                    final searchTourismPlace = state.searchTourismPlace[index];
                    for (var element in state.tourismPlace) {
                      ratePlaceMap
                          .addAll({element.id: element.rate_value ?? 0});
                    }
                    for (var element in state.tourismPlace) {
                      favPlaceMap.addAll({element.id: element.fav_value ?? 0});
                    }
                    return SeachBody(
                      data: searchTourismPlace,
                      type: "places",
                    );
                  },
                );

              case RequestState.error:
                return const Center(child: Text("Error"));
            }
          } else {
            return HotelsSearch(hotelSearchByFeild: textSearchByFeild);
          }
        case RequestState.error:
          BlocProvider.of<TourismPlaceBloc>(context).add(
              SearchTourismPlaceByFieldsEvent(
                  tourismPlaceSearchByFeild: textSearchByFeild));
          return const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()));
      }
    }));
  }
}
