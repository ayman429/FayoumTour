import 'package:flutter/material.dart';

import '../TourismPlaces/presentation/screens/tourism_places_search.dart';
import '../core/utils/app_localizations.dart';

class SEARCH extends StatelessWidget {
  String search_ketword;
  int search_count;
  SEARCH({
    Key? key,
    required this.search_ketword,
    required this.search_count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (search_ketword == "")
        ? Center(
            child: Text(
              AppLocalizations.of(context)!
                  .translate("Please Write Something!"),
              style: TextStyle(
                  fontFamily: "pressStart2p",
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.primary),
            ),
          )
        : TourismPlacesSearch(textSearchByFeild: search_ketword);
  }
}
