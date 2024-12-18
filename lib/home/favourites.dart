import 'package:cached_network_image/cached_network_image.dart';
import 'package:fayoumtour/core/utils/constance/strings_manager.dart';
import 'package:flutter/material.dart';

import '../TourismPlaces/presentation/screens/places_details.dart';
import '../core/local_data_shared_preferences/favourites_shared_preferences.dart';
import '../core/utils/app_localizations.dart';
import '../core/utils/constance/shared_pref.dart';
import '../hotels/presentation/screens/hotels_details.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Map<String, dynamic>>? snapshot;

  @override
  Widget build(BuildContext context) {
    FavouritStorage().getFavourits().then((value) => setState(
          () {
            snapshot = value;
            // print(snapshot);
          },
        ));
    if (snapshot == null || snapshot!.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.translate("Nothing Yet fav"),
          style: TextStyle(
              fontFamily: sharedPreferences!.getString("Language") == "AR"
                  ? "aref"
                  : "pressStart2p",
              fontSize:
                  sharedPreferences!.getString("Language") == "AR"
                  ? (38/360)*MediaQuery.of(context).size.width//38
                  : (23/360)*MediaQuery.of(context).size.width,//23,
              color: Theme.of(context).colorScheme.primary),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: snapshot!.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (snapshot![index]["type"] == "places") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PlacesDetails(tourId: snapshot![index]["id"])));
              } else if (snapshot![index]["type"] == "hotels") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HotelsDetails(hotelsId: snapshot![index]["id"])));
              } else {
                //print("error");
              }
            },
            child: Container(
              height: (200/772)*MediaQuery.of(context).size.height,//200,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(7),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                          Colors.black,
                          Colors.transparent,
                        ],
                        stops: [0, 0.2, 0.8, 1],
                      ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child:
                      CachedNetworkImage(imageUrl: snapshot![index]["image"],
                      fadeInDuration: const Duration(milliseconds: 300),
                  fadeOutDuration: const Duration(milliseconds: 50),
                fit: BoxFit.cover,
                placeholder: (context, url) {
                    return Image.asset(AppStrings.loading2Gif,fit: BoxFit.cover,);
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(AppStrings.error1Gif,fit: BoxFit.cover,);
                  },
                      )
                      // Image.network(
                      //   snapshot![index]["image"],
                      //   fit: BoxFit.cover,
                      //   errorBuilder: (context, error, stackTrace) {
                      //     return Image.asset(AppStrings.error1Gif);
                      //   },
                      //   loadingBuilder: (context, child, loadingProgress) {
                      //     if (loadingProgress != null) {
                      //       return Image.asset(AppStrings.loading2Gif);
                      //     }
                      //     return child;
                      //   },
                      // ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            FavouritStorage()
                                .deleteFavourit(snapshot![index]['name']);
                          });
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        sharedPreferences!.getString("Language") == "AR"
                            ? snapshot![index]["nameAR"]
                            : snapshot![index]["name"],
                        style: TextStyle(
                          fontFamily:
                              sharedPreferences!.getString("Language") == "AR"
                                  ? "lemo"
                                  : "merriweather",
                          fontWeight: FontWeight.bold,
                          fontSize: (18/360)*MediaQuery.of(context).size.width,//18,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}


/*
    // return StreamBuilder<List<dynamic>>(
    //     stream: FavouritStorage().getFavourits().asStream(),
    //     builder: (context, snapshot) {
    //       if (snapshot.data == null) {
    //         return Center(
    //           child: Text(
    //             "Nothing Yet",
    //             style: GoogleFonts.pressStart2p(
    //                 fontSize: 25, color: Theme.of(context).colorScheme.primary),
    //           ),
    //         );
    //       } else {
    //         return ListView.builder(
    //           itemCount: snapshot.data!.length,
    //           itemBuilder: (context, index) {
    //             return InkWell(
    //               onTap: () {
    //                 if (snapshot.data![index]["type"] == "places") {
    //                   Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) => FavoritePlacesDetails(
    //                               tourId: snapshot.data![index]["id"])));
    //                 } else if (snapshot.data![index]["type"] == "hotels") {
    //                   Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) => FavoriteHotelsDetails(
    //                               hotelsId: snapshot.data![index]["id"])));
    //                 } else {
    //                   print("error");
    //                 }
    //               },
    //               child: Container(
    //                 height: 200,
    //                 margin:
    //                     const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    //                 decoration: BoxDecoration(
    //                   color: Theme.of(context).colorScheme.secondary,
    //                   borderRadius: BorderRadius.circular(7),
    //                   boxShadow: const [
    //                     BoxShadow(
    //                       color: Colors.grey,
    //                       blurRadius: 6,
    //                     ),
    //                   ],
    //                 ),
    //                 child: Stack(
    //                   fit: StackFit.expand,
    //                   children: [
    //                     ShaderMask(
    //                       shaderCallback: (rect) {
    //                         return const LinearGradient(
    //                           begin: Alignment.topCenter,
    //                           end: Alignment.bottomCenter,
    //                           colors: [
    //                             Colors.transparent,
    //                             Colors.black,
    //                             Colors.black,
    //                             Colors.transparent,
    //                           ],
    //                           stops: [0, 0.2, 0.8, 1],
    //                         ).createShader(
    //                             Rect.fromLTRB(0, 0, rect.width, rect.height));
    //                       },
    //                       blendMode: BlendMode.dstIn,
    //                       child: ClipRRect(
    //                         borderRadius: BorderRadius.circular(7),
    //                         child: Image.network(
    //                           snapshot.data![index]["image"],
    //                           fit: BoxFit.cover,
    //                           errorBuilder: (context, error, stackTrace) {
    //                             return Image.asset(AppStrings.error1Gif);
    //                           },
    //                           loadingBuilder:
    //                               (context, child, loadingProgress) {
    //                             if (loadingProgress != null) {
    //                               return Image.asset(AppStrings.loading2Gif);
    //                             }
    //                             return child;
    //                           },
    //                         ),
    //                       ),
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         IconButton(
    //                           onPressed: () {},
    //                           icon: const Icon(
    //                             Icons.favorite,
    //                             color: Colors.red,
    //                           ),
    //                         ),
    //                         IconButton(
    //                           onPressed: () async {
    //                             setState(() {
    //                               FavouritStorage().deleteFavourit(
    //                                   snapshot.data![index]['name']);
    //                             });
    //                           },
    //                           icon: Icon(
    //                             Icons.cancel,
    //                             color: Theme.of(context).colorScheme.onPrimary,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       crossAxisAlignment: CrossAxisAlignment.end,
    //                       children: [
    //                         Text(
    //                           snapshot.data![index]["name"],
    //                           style: GoogleFonts.merriweather(
    //                             fontSize: 18,
    //                             color: Theme.of(context).colorScheme.onPrimary,
    //                           ),
    //                           overflow: TextOverflow.ellipsis,
    //                           maxLines: 1,
    //                         )
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             );
    //           },
    //         );
    //       }
    //     });
 */