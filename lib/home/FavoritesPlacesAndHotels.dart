import 'package:flutter/material.dart';

import '../TourismPlaces/presentation/screens/get_favorites.dart';
import '../hotels/presentation/screens/get_favorites.dart';

class FavoritesPlacesAndHotels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        GetTourismPlacesFavorite(),
        GetHotelFavorite(),
      ],
    );
  }
}
