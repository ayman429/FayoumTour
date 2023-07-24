import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/enums.dart';
import '../../../home/favourites.dart';
import '../controller/tourism_place_bloc.dart';
import '../controller/tourism_place_event.dart';
import '../controller/tourism_place_state.dart';

class GetTourismPlacesFavorite extends StatelessWidget {
  const GetTourismPlacesFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      return getIt<TourismPlaceBloc>()..add(GetTourismPlaceFavoriteEvent());
    }, child: BlocBuilder<TourismPlaceBloc, TourismPlaceState>(
        builder: (context, state) {
      BlocProvider.of<TourismPlaceBloc>(context)
          .add(GetTourismPlaceFavoriteEvent());
      switch (state.getTourismPlaceFavoriteState) {
        case RequestState.loading:
          return const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()));
        case RequestState.loaded:
          print("loaded");

          print("loaded");
          if (state.getTourismPlaceFavorite.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.translate("Nothing Yet fav"),
                style: TextStyle(
                    fontFamily: "pressStart2p",
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.primary),
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.builder(
                itemCount: state.getTourismPlaceFavorite.length,
                itemBuilder: (context, index) {
                  final getTourismPlaceFavorite =
                      state.getTourismPlaceFavorite[index];
                  for (var element in state.tourismPlace) {
                    ratePlaceMap.addAll({element.id: element.rate_value ?? 0});
                  }
                  for (var element in state.tourismPlace) {
                    favPlaceMap.addAll({element.id: element.fav_value ?? 0});
                  }

                  return Favorites(
                    data: getTourismPlaceFavorite,
                    index: 0,
                    type: "places",
                  );
                },
              ),
            );
          }
        case RequestState.error:
          return const Center(child: Text("Error"));
      }
    }));
  }
}
