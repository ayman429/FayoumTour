// import 'dart:math';

// import 'package:fayoumtour/hotels/domain/entities/hotel.dart';
// import 'package:fayoumtour/TourismPlaces/domain/entities/tourism_place.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/services/services_locator.dart';
// import '../../../core/utils/app_localizations.dart';
// import '../../../core/utils/enums.dart';
// import 'favourites_API.dart';
// import '../hotels/presentation/controller/hotels_bloc.dart';
// import '../hotels/presentation/controller/hotels_event.dart';
// import '../hotels/presentation/controller/hotels_state.dart';
// import '../TourismPlaces/presentation/controller/tourism_place_bloc.dart';
// import '../TourismPlaces/presentation/controller/tourism_place_event.dart';
// import '../TourismPlaces/presentation/controller/tourism_place_state.dart';

// class FavoritesPlacesAndHotels extends StatelessWidget {
//   const FavoritesPlacesAndHotels({super.key});
//   @override
//   Widget build(BuildContext context) {
//     TourismPlace? getTourismPlaceFavorite;
//     Hotel? getHotelFavorite;
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => getIt<TourismPlaceBloc>()..add(GetTourismPlaceFavoriteEvent())),
//         BlocProvider(create: (context) => getIt<HotelsBloc>()..add(GetHotelFavoriteEvent())),
//       ],
//       child: BlocBuilder<TourismPlaceBloc, TourismPlaceState>(
//         builder: (context, state) {
//           BlocProvider.of<TourismPlaceBloc>(context).add(GetTourismPlaceFavoriteEvent());
//           return BlocBuilder<HotelsBloc, HotelsState>(
//             builder: (context, stat) {
//               BlocProvider.of<HotelsBloc>(context).add(GetHotelFavoriteEvent());
//               if(state.getTourismPlaceFavoriteState == RequestState.loading || stat.getHotelFavoriteState == RequestState.loading)
//               {
//                 return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
//               }
//               else if(state.getTourismPlaceFavoriteState == RequestState.loaded && stat.getHotelFavoriteState == RequestState.loaded)
//               {
//                 if (state.getTourismPlaceFavorite.isEmpty && stat.getHotelFavorite.isEmpty)
//                 {
//                   return Center(
//               child: Text(
//                 AppLocalizations.of(context)!.translate("Nothing Yet fav"),
//                 style: TextStyle(
//                     fontFamily: "pressStart2p",
//                     fontSize: 25,
//                     color: Theme.of(context).colorScheme.primary),
//               ),
//             );
//                 }
//                 else{
//                   return ListView.builder(
//                 itemCount: max(state.getTourismPlaceFavorite.length, stat.getHotelFavorite.length),
//                 itemBuilder: (context, index) {
//                   if(index < state.getTourismPlaceFavorite.length)
//                   {
//                   getTourismPlaceFavorite = state.getTourismPlaceFavorite[index];
//                   for (var element in state.tourismPlace) {
//                     ratePlaceMap.addAll({element.id: element.rate_value ?? 0});
//                   }
//                   for (var element in state.tourismPlace) {
//                     favPlaceMap.addAll({element.id: element.fav_value ?? 0});
//                   }
//                   }

//                   if(index < stat.getHotelFavorite.length)
//                   {
//                   getHotelFavorite = stat.getHotelFavorite[index];
//                   for (var element in stat.hotels) {
//                     rateHotelMap.addAll({element.id: element.rate_value ?? 0});
//                   }
//                   for (var element in stat.hotels) {
//                     favHotelMap.addAll({element.id: element.fav_value ?? 0});
//                   }
//                   }
                  
//                   return Column(
//                     children: [
//                       index < state.getTourismPlaceFavorite.length ? Favorites(data: getTourismPlaceFavorite,index: 0,type: "places",) : Container(),
//                       index < stat.getHotelFavorite.length ? Favorites(data: getHotelFavorite,index: 1,type: "hotels",) : Container(),
//                     ],
//                   );
//                 },
//               );
//                 }
//               }
//               else
//               {
//                 return const Center(child: Text("Error"));
//               }
//             }
//           );
//         }
//       ),
//     );
    
//     // return Column(
//     //   children: const [
//     //     GetTourismPlacesFavorite(),
//     //     GetHotelFavorite(),
//     //   ],
//     // );
//   }
// }
