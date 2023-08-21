import 'package:flutter/material.dart';
import '../TourismPlaces/presentation/screens/nearest_tourism_places.dart';
import 'package:location/location.dart';

import '../core/utils/app_localizations.dart';
import '../core/utils/constance/shared_pref.dart';

Location location = Location();
bool serviceEnabled = false;
LocationData? locationData;
double latitude = 0;
double longitude = 0;

class NEAR extends StatefulWidget {
  const NEAR({super.key});

  @override
  State<NEAR> createState() => _NEARState();
}

class _NEARState extends State<NEAR> {
  @override
  Widget build(BuildContext context) {
    return serviceEnabled
        ? NearestTourismPlaces(
            lat: latitude,
            lon: longitude,
          )
        : Center(
            child: TextButton(
              onPressed: () async {
                serviceEnabled = await location.serviceEnabled();
                if (!serviceEnabled) {
                  serviceEnabled = await location.requestService();
                  if (!serviceEnabled) {
                    debugPrint('Location Denied once');
                    return;
                  }
                }

                if (serviceEnabled) {
                  locationData = await location.getLocation();
                  latitude = locationData!.latitude!;
                  longitude = locationData!.longitude!;
                  setState(() {});
                }
              },
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 10),
              child: Padding(
                padding:
                    sharedPreferences!.getString("Language") == "AR" ? const EdgeInsets.symmetric(vertical: 10, horizontal: 20)
                    : const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Text(
                  // "Get Nearest Places!",
                  AppLocalizations.of(context)!
                      .translate("Get Nearest Places!"),
                  style: TextStyle(
                      fontFamily: sharedPreferences!.getString("Language") == "AR" ? "Mag" : "rye",
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: (18/360)*MediaQuery.of(context).size.width,//18,
                      ),
                ),
              ),
            ),
          );
  }
}
