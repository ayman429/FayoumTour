import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/enums.dart';
import '../../../home/search_body.dart';
import '../controller/hotels_bloc.dart';
import '../controller/hotels_event.dart';
import '../controller/hotels_state.dart';

class HotelsSearch extends StatelessWidget {
  final String hotelSearchByFeild;

  const HotelsSearch({
    Key? key,
    required this.hotelSearchByFeild,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      return getIt<HotelsBloc>()
        ..add(SearchHotelByFieldsEvent(hotelSearchByFeild: hotelSearchByFeild));
    }, child: BlocBuilder<HotelsBloc, HotelsState>(builder: (context, state) {
      BlocProvider.of<HotelsBloc>(context).add(
        SearchHotelByFieldsEvent(
          hotelSearchByFeild: hotelSearchByFeild,
        ),
      );
      switch (state.searchHotelState) {
        case RequestState.loading:
          return const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()));
        case RequestState.loaded:
          if (state.searchHotels.isNotEmpty) {
            switch (state.searchHotelState) {
              case RequestState.loading:
                return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()));
              case RequestState.loaded:
                return ListView.builder(
                  itemCount: state.searchHotels.length,
                  itemBuilder: (context, index) {
                    final searchHotel = state.searchHotels[index];
                    for (var element in state.hotels) {
                      rateHotelMap
                          .addAll({element.id: element.rate_value ?? 0});
                    }
                    for (var element in state.hotels) {
                      favHotelMap.addAll({element.id: element.fav_value ?? 0});
                    }
                    return SeachBody(
                      data: searchHotel,
                      type: "hotels",
                    );
                  },
                );

              case RequestState.error:
                return const Center(child: Text("Error"));
            }
          } else {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.translate("Not Found!"),
                style: TextStyle(
                    fontFamily: sharedPreferences!.getString("Language") == "AR"
                        ? "aref"
                        : "pressStart2p",
                    fontSize: sharedPreferences!.getString("Language") == "AR"
                        ? 38
                        : 22,
                    height: sharedPreferences!.getString("Language") == "AR"
                        ? null
                        : 1.7,
                    color: Theme.of(context).colorScheme.primary),
              ),
            );
          }
        case RequestState.error:
          BlocProvider.of<HotelsBloc>(context).add(
              SearchHotelByFieldsEvent(hotelSearchByFeild: hotelSearchByFeild));
          return const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()));
      }
    }));
  }
}
