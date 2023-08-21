import 'package:fayoumtour/hotels/presentation/controller/hotels_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/enums.dart';
import '../../../home/HomeCardsLoading.dart';
import '../../../home/home_card_of_tourism_hotel.dart';
import '../controller/hotels_bloc.dart';
import '../controller/hotels_state.dart';

class TopRatedHotels extends StatelessWidget {
  const TopRatedHotels({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.translate("Top Rated Hotels"),
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
      BlocProvider(create: (context) {
        return getIt<HotelsBloc>()..add(SearchHotelByRateEvent());
      }, child: BlocBuilder<HotelsBloc, HotelsState>(builder: (context, state) {
        switch (state.searchHotelRateState) {
          case RequestState.loading:
            //return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
            return const HomeLoading();
          case RequestState.loaded:
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.builder(
                itemCount: state.searchHotelRate.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final searchHotelRate = state.searchHotelRate[index];
                  for (var element in state.hotels) {
                    rateHotelMap.addAll({element.id: element.rate_value ?? 0});
                  }
                  for (var element in state.hotels) {
                    favHotelMap.addAll({element.id: element.fav_value ?? 0});
                  }
                  return HomeCard(
                    data: searchHotelRate,
                    index: 1,
                    type: "hotels",
                  );
                },
              ),
            );
          case RequestState.error:
            //print("bbbbbbbbbbbbbbbbbbbb");
            BlocProvider.of<HotelsBloc>(context).add(SearchHotelByRateEvent());
            return const SizedBox(
                height: 200, child: Center(child: CircularProgressIndicator()));
        }
      }))
    ]);
  }
}
