import 'package:flutter/material.dart';

import '../TourismPlaces/presentation/components/home_cards_tourism_places.dart';
import '../TourismPlaces/presentation/components/search_by_field.dart';
import '../hotels/presentation/components/home_cards_hotels.dart';
import 'fayoum_vedio.dart';

class Home extends StatelessWidget {
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
              HomeCardsTourismPlaces(),
              HomeCardsHotels(),
              HomeCardsTourismPlacesSearch(
                  tourismPlaceSearchByFeild:
                      "Pharaonic relics"), //"Pharaonic antiquities"
            ]))
          ]))
    ]);
  }
}
