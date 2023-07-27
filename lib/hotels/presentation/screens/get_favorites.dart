// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../core/services/services_locator.dart';
// import '../../../core/utils/app_localizations.dart';
// import '../../../core/utils/enums.dart';
// import '../../../home/favourites_API.dart';
// import '../controller/hotels_bloc.dart';
// import '../controller/hotels_event.dart';
// import '../controller/hotels_state.dart';

// class GetHotelFavorite extends StatelessWidget {
//   const GetHotelFavorite({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(create: (context) {
//       return getIt<HotelsBloc>()..add(GetHotelFavoriteEvent());
//     }, child: BlocBuilder<HotelsBloc, HotelsState>(builder: (context, state) {
//       BlocProvider.of<HotelsBloc>(context).add(GetHotelFavoriteEvent());
//       switch (state.getHotelFavoriteState) {
//         case RequestState.loading:
//           return const SizedBox(
//               height: 200, child: Center(child: CircularProgressIndicator()));
//         case RequestState.loaded:
//           print("loaded");
//           if (state.getHotelFavorite.isEmpty) {
//             return Center(
//               child: Text(
//                 AppLocalizations.of(context)!.translate("Nothing Yet fav"),
//                 style: TextStyle(
//                     fontFamily: "pressStart2p",
//                     fontSize: 25,
//                     color: Theme.of(context).colorScheme.primary),
//               ),
//             );
//           } else {
//             return SizedBox(
//               height: MediaQuery.of(context).size.height * 0.25,
//               child: ListView.builder(
//                 itemCount: state.getHotelFavorite.length,
//                 itemBuilder: (context, index) {
//                   final getHotelFavorite = state.getHotelFavorite[index];
//                   for (var element in state.hotels) {
//                     rateHotelMap.addAll({element.id: element.rate_value ?? 0});
//                   }
//                   for (var element in state.hotels) {
//                     favHotelMap.addAll({element.id: element.fav_value ?? 0});
//                   }

//                   return Favorites(
//                     data: getHotelFavorite,
//                     index: 1,
//                     type: "hotels",
//                   );
//                 },
//               ),
//             );
//           }
//         case RequestState.error:
//           return const Center(child: Text("Error"));
//       }
//     }));
//   }
// }
