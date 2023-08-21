import 'package:flutter/material.dart';

import '../TourismPlaces/presentation/screens/tourism_places_search.dart';
import '../core/utils/app_localizations.dart';
import '../core/utils/constance/shared_pref.dart';

class SEARCH extends StatelessWidget {
  final String searchKetword;
  final int searchCount;
  const SEARCH({
    Key? key,
    required this.searchKetword,
    required this.searchCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return searchKetword == ""
        ? Center(
            child: Text(
              AppLocalizations.of(context)!
                  .translate("Please Write Something!"),
              style: TextStyle(
                  fontFamily: sharedPreferences!.getString("Language") == "AR"
                      ? "aref"
                      : "pressStart2p",
                  fontSize: sharedPreferences!.getString("Language") == "AR"
                      ? (38/360)*MediaQuery.of(context).size.width//38
                      : (22/360)*MediaQuery.of(context).size.width,//22,
                  height: sharedPreferences!.getString("Language") == "AR"
                      ? null
                      : 1.7,
                  color: Theme.of(context).colorScheme.primary),
            ),
          )
        : TourismPlacesSearch(textSearchByFeild: searchKetword);
  }
}
