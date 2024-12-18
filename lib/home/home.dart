import 'package:flutter/material.dart';

import '../TourismPlaces/presentation/screens/home_cards_tourism_places.dart';
import '../TourismPlaces/presentation/screens/places_search_type_by_field.dart';
import '../TourismPlaces/presentation/screens/recommendations.dart';
import '../TourismPlaces/presentation/screens/top_rated_places.dart';
import '../hotels/presentation/screens/home_cards_hotels.dart';
import '../hotels/presentation/screens/top_rated_hotels.dart';
import 'fayoum_vedio.dart';

class Home extends StatelessWidget {
  final String tourtismType;
  const Home({
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
            const recommendations(),
            SingleChildScrollView(
              child: Column(
                children: [
                  const TopRatedTourismPlaces(),
                  const TopRatedHotels(),
                  HomeCardsTourismPlacesTypeSearch(
                      tourismPlaceSearchByFeild: tourtismType),
                  const HomeCardsTourismPlaces(),
                  const HomeCardsHotels(),
                ],
              ),
            )
          ]))
    ]);
  }
}
