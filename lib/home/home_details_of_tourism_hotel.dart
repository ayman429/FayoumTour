import 'package:cached_network_image/cached_network_image.dart';
import 'package:fayoumtour/core/utils/constance/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import '../core/utils/app_localizations.dart';
import '../core/utils/constance/shared_pref.dart';
import 'RatingStarsBar.dart';
import 'StarsRating.dart';
import 'image_list.dart';
import 'reserve.dart';

class Details extends StatelessWidget {
  var data;
  int index;
  Details({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.49,
      padding: const EdgeInsets.only(top: 20, left: 0, right: 0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          )),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //GetData(collection: "Area", isSearch: true,type: 1,SearchKey1: widget.ro,SearchKey2: "name",),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                        child: Text(
                          sharedPreferences!.getString("Language") == "AR"
                              ? data.nameAR
                              : data.name,
                          style: TextStyle(
                              fontFamily:
                                  sharedPreferences!.getString("Language") ==
                                          "AR"
                                      ? "messiri"
                                      : "acme",
                              fontSize: (20.5/360)*MediaQuery.of(context).size.width,//20.5,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: sharedPreferences!.getString("Language") == "AR"
                            ? 0
                            : 7,
                        left: sharedPreferences!.getString("Language") == "AR"
                            ? 7
                            : 0,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right:
                                    sharedPreferences!.getString("Language") ==
                                            "AR"
                                        ? 0
                                        : 2,
                                left:
                                    sharedPreferences!.getString("Language") ==
                                            "AR"
                                        ? 2
                                        : 0,
                                top: sharedPreferences!.getString("Language") ==
                                        "AR"
                                    ? 4
                                    : 2),
                            child: Text(
                              data.avgRatings.toString(),
                              style: sharedPreferences!.getString("Language") ==
                                      "AR"
                                  ?  TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "messiri",
                                      fontSize: (16/360)*MediaQuery.of(context).size.width,//16
                                      )
                                  :  TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "acme",
                                      fontSize: (16/360)*MediaQuery.of(context).size.width,//16
                                      ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(),
                              child: RatingBar(
                                rating: data.avgRatings,
                                size: (22/360)*MediaQuery.of(context).size.width,//22,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: sharedPreferences!.getString("Language") == "AR"
                          ? const EdgeInsets.fromLTRB(10, 5, 20, 5)
                          : const EdgeInsets.fromLTRB(20, 5, 10, 5),
                      child: Text(
                        sharedPreferences!.getString("Language") == "AR"
                            ? data.descriptionAR
                            : data.description,
                        style: TextStyle(
                            fontFamily:
                                sharedPreferences!.getString("Language") == "AR"
                                    ? "ibmP"
                                    : "domine",
                            height:
                                sharedPreferences!.getString("Language") == "AR"
                                    ? 1.75
                                    : 1.50,
                            fontSize: (18/360)*MediaQuery.of(context).size.width,//18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    )),

                const SizedBox(
                  height: 10,
                ),

                Container(
                  margin: EdgeInsets.only(
                    left: sharedPreferences!.getString("Language") == "AR"
                        ? 0
                        : 15,
                    right: sharedPreferences!.getString("Language") == "AR"
                        ? 15
                        : 0,
                  ),
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                            left:
                                sharedPreferences!.getString("Language") == "AR"
                                    ? 5
                                    : 0,
                            right:
                                sharedPreferences!.getString("Language") == "AR"
                                    ? 0
                                    : 5,
                          ),
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImageList(
                                        imageList: data.imagesT, index: 0))),
                            child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: data.imagesT[0].imageT,
                                        fadeInDuration:
                                            const Duration(milliseconds: 300),
                                        fadeOutDuration:
                                            const Duration(milliseconds: 50),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) {
                                          return Image.asset(
                                            "assets/images/photoLoading.jpeg",
                                            fit: BoxFit.cover,
                                          );
                                        },
                                        errorWidget: (context, url, error) {
                                          return Image.asset(
                                            AppStrings.error1Gif,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      )
                                      // Image.network(
                                      //       data.imagesT[0].imageT,
                                      //       fit: BoxFit.cover,
                                      //       errorBuilder: (context, error, stackTrace) {
                                      //         return Image.asset(
                                      //           AppStrings.error1Gif,
                                      //           fit: BoxFit.cover,
                                      //         );
                                      //       },
                                      //       loadingBuilder:
                                      //           (context, child, loadingProgress) {
                                      //         if (loadingProgress != null) {
                                      //           return Image.asset(
                                      //             AppStrings.loading2Gif,
                                      //             fit: BoxFit.cover,
                                      //           );
                                      //         }
                                      //         return child;
                                      //       },
                                      //     ),
                                      ),
                                ),
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                            left:
                                sharedPreferences!.getString("Language") == "AR"
                                    ? 5
                                    : 0,
                            right:
                                sharedPreferences!.getString("Language") == "AR"
                                    ? 0
                                    : 5,
                          ),
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImageList(
                                        imageList: data.imagesT, index: 1))),
                            child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: data.imagesT[1].imageT,
                                      fadeInDuration:
                                          const Duration(milliseconds: 300),
                                      fadeOutDuration:
                                          const Duration(milliseconds: 50),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return Image.asset(
                                          "assets/images/photoLoading.jpeg",
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      errorWidget: (context, url, error) {
                                        return Image.asset(
                                          AppStrings.error1Gif,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                    // Image.network(
                                    //   data.imagesT[1].imageT,
                                    //   fit: BoxFit.cover,
                                    //   errorBuilder: (context, error, stackTrace) {
                                    //     return Image.asset(
                                    //       AppStrings.error1Gif,
                                    //       fit: BoxFit.cover,
                                    //     );
                                    //   },
                                    //   loadingBuilder:
                                    //       (context, child, loadingProgress) {
                                    //     if (loadingProgress != null) {
                                    //       return Image.asset(
                                    //         AppStrings.loading2Gif,
                                    //         fit: BoxFit.cover,
                                    //       );
                                    //     }
                                    //     return child;
                                    //   },
                                    // ),
                                  ),
                                ),
                              
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                            left:
                                sharedPreferences!.getString("Language") == "AR"
                                    ? 5
                                    : 0,
                            right:
                                sharedPreferences!.getString("Language") == "AR"
                                    ? 0
                                    : 5,
                          ),
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImageList(
                                        imageList: data.imagesT, index: 2))),
                            child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Opacity(
                                      opacity: 0.5,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.30,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: CachedNetworkImage(
                                              imageUrl: data.imagesT[2].imageT,
                                              fadeInDuration: const Duration(
                                                  milliseconds: 300),
                                              fadeOutDuration: const Duration(
                                                  milliseconds: 50),
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) {
                                                return Image.asset(
                                                  "assets/images/photoLoading.jpeg",
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                              errorWidget:
                                                  (context, url, error) {
                                                return Image.asset(
                                                  AppStrings.error1Gif,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            )
                                            // Image.network(
                                            //   data.imagesT[2].imageT,
                                            //   fit: BoxFit.cover,
                                            //   errorBuilder:
                                            //       (context, error, stackTrace) {
                                            //     return Image.asset(
                                            //       AppStrings.error1Gif,
                                            //       fit: BoxFit.cover,
                                            //     );
                                            //   },
                                            //   loadingBuilder:
                                            //       (context, child, loadingProgress) {
                                            //     if (loadingProgress != null) {
                                            //       return Image.asset(
                                            //         AppStrings.loading2Gif,
                                            //         fit: BoxFit.cover,
                                            //       );
                                            //     }
                                            //     return child;
                                            //   },
                                            // ),
                                            ),
                                      ),
                                    ),
                                    Text(
                                      "+${data.imagesT.length - 2}",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: (27/360)*MediaQuery.of(context).size.width,//27,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              
                          )),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // Rate
                index == 1
                    ? RatingScreen(
                        id: data.id,
                        rate_value: data.rate_value,
                        type: "hotel",
                      )
                    : RatingScreen(
                        id: data.id,
                        rate_value: data.rate_value ?? 0,
                        type: "places",
                      ),
                const SizedBox(
                  height: 10,
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                  child: SizedBox(
                    height: 55,
                    width: 260,
                    child: TextButton(
                      onPressed: () async {
                        Location location = Location();
                        bool serviceEnabled;
                        serviceEnabled = await location.serviceEnabled();
                        if (!serviceEnabled) {
                          serviceEnabled = await location.requestService();
                          if (!serviceEnabled) {
                            debugPrint('Location Denied once');
                            return;
                          }
                        }
                        final url =
                            "https://www.google.com/maps/search/?api=1&query=${data.coordinatesX},${data.coordinatesY}";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 10),
                      child: Text(
                        // "Go to it!",
                        AppLocalizations.of(context)!.translate("Go to it!"),
                        style: TextStyle(
                            fontFamily:
                                sharedPreferences!.getString("Language") == "AR"
                                    ? "Mag"
                                    : "rye",
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: (20/360)*MediaQuery.of(context).size.width,//20
                            ),
                      ),
                    ),
                  ),
                ),

                index == 1
                    ? Container(
                        margin: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                        child: SizedBox(
                          height: 55,
                          width: 260,
                          child: TextButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HotelReservationScreen(
                                            hotelId: data.id,
                                            type: "add",
                                            data: "",
                                          )));
                            },
                            style: TextButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 10),
                            child: Text(
                              // "Reserve!",
                              AppLocalizations.of(context)!
                                  .translate("Reserve!"),
                              style: TextStyle(
                                  fontFamily: sharedPreferences!
                                              .getString("Language") ==
                                          "AR"
                                      ? "Mag"
                                      : "rye",
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: (20/360)*MediaQuery.of(context).size.width,//20
                                  ),
                            ),
                          ),
                        ),
                      )
                    : Container(),

                // Align(
                //     alignment: Alignment.centerLeft,
                //     child: Container(
                //       margin: const EdgeInsets.all(20),
                //       child: Text(
                //         "The Near Hotels: ",
                //         style: GoogleFonts.acme(
                //             fontSize: 22,
                //             fontWeight: FontWeight.bold,
                //             color: Theme.of(context).colorScheme.primary),
                //       ),
                //     )),

                // HOTELS(area_name: snapshot.data?.docs[0]["name"]),

                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
