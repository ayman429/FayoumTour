import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/enums.dart';
import '../../../home/HomeCardsLoading.dart';
import '../../../home/home_card_of_tourism_hotel.dart';
import '../controller/hotels_bloc.dart';
import '../controller/hotels_event.dart';
import '../controller/hotels_state.dart';

class HomeCardsHotels extends StatelessWidget {
  const HomeCardsHotels({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.translate("Hotels"),
                style: sharedPreferences!.getString("Language") == "AR"
                    ?  TextStyle(fontFamily: "dg", fontSize: (18/360)*MediaQuery.of(context).size.width,//18,
                    )
                    :  TextStyle(fontFamily: "alata", fontSize: (18/360)*MediaQuery.of(context).size.width,//18,
                    ),
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.translate("See More"),
                    style: sharedPreferences!.getString("Language") == "AR"
                    ?  TextStyle(fontFamily: "dg", fontSize: (18/360)*MediaQuery.of(context).size.width,//18,
                    )
                    :  TextStyle(fontFamily: "alata", fontSize: (18/360)*MediaQuery.of(context).size.width,//18,
                    ),
                  ),
                  const Icon(Icons.arrow_right)
                ],
              ),
            ],
          )),
      BlocProvider(create: (BuildContext context) {
        return getIt<HotelsBloc>()..add(GetHotelsEvent());
      }, child: BlocBuilder<HotelsBloc, HotelsState>(builder: (context, state) {
        switch (state.hotelState) {
          case RequestState.loading:
            //return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
            return const HomeLoading();
          case RequestState.loaded:
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.builder(
                itemCount: state.hotels.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final hotels = state.hotels[index];
                  for (var element in state.hotels) {
                    rateHotelMap.addAll({element.id: element.rate_value ?? 0});
                  }
                  for (var element in state.hotels) {
                    favHotelMap.addAll({element.id: element.fav_value ?? 0});
                  }
                  return HomeCard(
                    data: hotels,
                    index: 1,
                    type: "hotels",
                  );
                  // Container(
                  //   //height: 200,
                  //   width: MediaQuery.of(context).size.width * 0.7,
                  //   margin:
                  //       const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  //   decoration: BoxDecoration(
                  //       color: Theme.of(context).colorScheme.secondary,
                  //       borderRadius: BorderRadius.circular(10),
                  //       boxShadow: const [
                  //         BoxShadow(
                  //           color: Colors.grey,
                  //           blurRadius: 6,
                  //           //offset: Offset(4,4),
                  //         ),
                  //       ]),
                  //   child: InkWell(
                  //     onTap: () {
                  //       // Navigator.push(
                  //       //     context,
                  //       //     MaterialPageRoute(
                  //       //         builder: (context) => BAR(
                  //       //               ro: snapshot.data
                  //       //                       ?.docs[index]
                  //       //                   ["name"],
                  //       //               img: snapshot.data
                  //       //                       ?.docs[index]
                  //       //                   ["images"][0],
                  //       //               index: 0,
                  //       //             )));
                  //     },
                  //     child: Stack(
                  //       fit: StackFit.expand,
                  //       children: [
                  //         ShaderMask(
                  //           shaderCallback: (rect) {
                  //             return const LinearGradient(
                  //               begin: Alignment.topCenter,
                  //               end: Alignment.bottomCenter,
                  //               colors: [
                  //                 Colors.transparent,
                  //                 Colors.black,
                  //                 Colors.black,
                  //                 Colors.transparent,
                  //               ],
                  //               stops: [0, 0, 0.6, 1],
                  //             ).createShader(
                  //                 Rect.fromLTRB(0, 0, rect.width, rect.height));
                  //           },
                  //           blendMode: BlendMode.dstIn,
                  //           child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(7),
                  //             child: Image.network(
                  //               hotels.originalImage,
                  //               fit: BoxFit.cover,
                  //               errorBuilder: (context, error, stackTrace) {
                  //                 return Image.asset(
                  //                   AppStrings.error1Gif,
                  //                   fit: BoxFit.cover,
                  //                 );
                  //               },
                  //               loadingBuilder:
                  //                   (context, child, loadingProgress) {
                  //                 if (loadingProgress != null) {
                  //                   return Image.asset(
                  //                     AppStrings.loading2Gif,
                  //                     fit: BoxFit.cover,
                  //                   );
                  //                 }
                  //                 return child;
                  //               },
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             crossAxisAlignment: CrossAxisAlignment.end,
                  //             children: [
                  //               Expanded(
                  //                 child: Text(
                  //                   hotels.name,
                  //                   style: GoogleFonts.alata(fontSize: 15),
                  //                   overflow: TextOverflow.ellipsis,
                  //                   maxLines: 1,
                  //                 ),
                  //               ),
                  //               Row(
                  //                 children: [
                  //                   Text(
                  //                     hotels.avgRatings.toString(),
                  //                     style: const TextStyle(fontSize: 15),
                  //                   ),
                  //                   RatingBar(
                  //                       rating: hotels.avgRatings,
                  //                       ratingCount: 0),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // );
                },
              ),
            );
          case RequestState.error:
            BlocProvider.of<HotelsBloc>(context).add(GetHotelsEvent());
            return const SizedBox(
                height: 200, child: Center(child: CircularProgressIndicator()));
        }
      }))
    ]);
  }
}
