import 'package:flutter/material.dart';

import '../TourismPlaces/presentation/screens/home_cards_tourism_places.dart';
import '../TourismPlaces/presentation/screens/nearest_tourism_places.dart';
import '../TourismPlaces/presentation/screens/places_search_type_by_field.dart';
import '../TourismPlaces/presentation/screens/top_rated_places.dart';
import '../hotels/presentation/screens/home_cards_hotels.dart';
import '../hotels/presentation/screens/top_rated_hotels.dart';
import 'fayoum_vedio.dart';


class Home extends StatelessWidget {
  String tourtismType;
  Home({
    Key? key,
    required this.tourtismType,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(children: [
// ------------------Youtube Player----------------------

            FayoumVedio(),
            const SizedBox(height: 10),
            SingleChildScrollView(
                child: Column(children: [
              const TopRatedTourismPlaces(),
              TopRatedHotels(),
              NearestTourismPlaces(),
              HomeCardsTourismPlacesTypeSearch(
                  tourismPlaceSearchByFeild: tourtismType),
              HomeCardsTourismPlaces(),
              HomeCardsHotels(),
            ],
            ),
            )
          ]))
    ]);
  }
}
