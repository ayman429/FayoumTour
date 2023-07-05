import 'package:flutter/material.dart';
import '../TourismPlaces/presentation/screens/nearest_tourism_places.dart';
import 'package:location/location.dart';
import 'package:google_fonts/google_fonts.dart';


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
    return serviceEnabled ? NearestTourismPlaces(lat: latitude,lon: longitude,)
      : Center(
      child: TextButton(
        onPressed: ()async{
          serviceEnabled = await location.serviceEnabled();
          if (!serviceEnabled) {
            serviceEnabled = await location.requestService();
            if (!serviceEnabled) {
              debugPrint('Location Denied once');
              return;
            }
          }
          
          if(serviceEnabled)
          {
            locationData = await location.getLocation();
            latitude = locationData!.latitude!;
            longitude = locationData!.longitude!;
            setState(() {
              
            });
          }
        },
        style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 10),
        child:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 40),
          child: Text("Get Nearest Places!",
          style: GoogleFonts.rye(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 18),),
        ),
      ),
    );
  }
}