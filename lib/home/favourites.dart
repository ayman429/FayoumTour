import 'package:flutter/material.dart';

import 'package:fayoumtour/core/utils/constance/strings_manager.dart';
import 'package:fayoumtour/home/up_bar_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../TourismPlaces/domain/entities/tourism_place_favorite.dart';
import '../TourismPlaces/presentation/controller/tourism_place_bloc.dart';
import '../TourismPlaces/presentation/controller/tourism_place_event.dart';
import '../TourismPlaces/presentation/controller/tourism_place_state.dart';
import '../core/services/services_locator.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/enums.dart';
import '../hotels/domain/entities/hotel_favorite.dart';
import '../hotels/presentation/controller/hotels_bloc.dart';
import '../hotels/presentation/controller/hotels_event.dart';
import '../hotels/presentation/controller/hotels_state.dart';

class Favorites extends StatelessWidget {
  dynamic data;
  int index;
  String type;
  Favorites({
    Key? key,
    required this.data,
    required this.index,
    required this.type,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UpBarImage(
                      data: data,
                      index: index,
                      type: type,
                    )));
      },
      child: Container(
        height: 200,
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
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.network(
                  data.originalImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(AppStrings.error1Gif,
                    fit: BoxFit.cover,
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return Image.asset(AppStrings.loading2Gif,
                      fit: BoxFit.cover,
                      );
                    }
                    return child;
                  },
                ),
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

                index == 0
                    ? BlocProvider.value(
                        value: getIt<TourismPlaceBloc>(),
                        child:
                            BlocConsumer<TourismPlaceBloc, TourismPlaceState>(
                          listener: (context, state) {
                            if (state.updateCreateTourismPlaceFavoriteState ==
                                RequestState.loaded) {
                              print("Loded");
                            } else if (state
                                    .updateCreateTourismPlaceFavoriteState ==
                                RequestState.loading) {
                              print("Loding");
                            } else if (state
                                    .updateCreateTourismPlaceFavoriteState ==
                                RequestState.error) {
                              // SnackBarMessage().showErrorSnackBar(
                              //     message: state.updateCreateTourismPlaceRateMessage,
                              //     context: context);
                            }
                          },
                          builder: (context, state) {
                            return IconButton(
                              onPressed: () async {
                                TourismPlaceFavorite tourismPlaceFavorite =
                                    TourismPlaceFavorite(
                                        fav: 0,
                                        placeId: data.id,
                                        user: int.parse(sharedPreferences!
                                                .getString("USERID") ??
                                            "0"));
                                BlocProvider.of<TourismPlaceBloc>(context)
                                    .add(UpdateCreateTourismPlaceFavoriteEvent(
                                  updateCreateTourFavorite:
                                      tourismPlaceFavorite,
                                ));
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            );
                          },
                        ),
                      )
                    : BlocProvider.value(
                        value: getIt<HotelsBloc>(),
                        child: BlocConsumer<HotelsBloc, HotelsState>(
                          listener: (context, state) {
                            if (state.updateCreateHotelFavoriteState ==
                                RequestState.loaded) {
                              print("Loded");
                            } else if (state.updateCreateHotelFavoriteState ==
                                RequestState.loading) {
                              print("Loding");
                            } else if (state.updateCreateHotelFavoriteState ==
                                RequestState.error) {
                              // SnackBarMessage().showErrorSnackBar(
                              //     message: state.updateCreateTourismPlaceRateMessage,
                              //     context: context);
                            }
                          },
                          builder: (context, state) {
                            return IconButton(
                              onPressed: () async {
                                HotelFavorite hotelFav = HotelFavorite(
                                    fav: 0,
                                    hotelId: data.id,
                                    user: int.parse(sharedPreferences!
                                            .getString("USERID") ??
                                        "0"));
                                BlocProvider.of<HotelsBloc>(context).add(
                                    UpdateCreateHotelFavoriteEvent(
                                        updateCreateHotelFavorite: hotelFav));
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            );
                          },
                        ),
                      ),

                // IconButton(
                //   onPressed: () async {

                //   },
                //   icon: Icon(
                //     Icons.cancel,
                //     color: Theme.of(context).colorScheme.onPrimary,
                //   ),
                // ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  sharedPreferences!.getString("Language") == "AR"
                      ? data.nameAR
                      : data.name,
                  style: TextStyle(
                    fontFamily: "merriweather",
                    fontSize: 18,
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