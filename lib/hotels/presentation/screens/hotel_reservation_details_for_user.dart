import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/app_localizations.dart';
import '../../../core/utils/constance/shared_pref.dart';
import '../../../core/utils/constance/strings_manager.dart';
import '../../../core/utils/enums.dart';
import '../../../home/reservations_list.dart';
import '../controller/hotels_bloc.dart';
import '../controller/hotels_event.dart';
import '../controller/hotels_state.dart';

class HotelsReservationDetailsForUser extends StatelessWidget {
  const HotelsReservationDetailsForUser({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      return getIt<HotelsBloc>();
    }, child: BlocBuilder<HotelsBloc, HotelsState>(builder: (context, state) {
      BlocProvider.of<HotelsBloc>(context).add(GetHotelsReservationByUserEvent(
          userId: int.parse(sharedPreferences!.getString("USERID") ?? "0")));
      switch (state.hotelReservationByUserState) {
        case RequestState.loading:
          return const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()));
        case RequestState.loaded:
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  AppLocalizations.of(context)!.translate("Reservation"),
                  style: sharedPreferences!.getString("Language") == "AR"
                      ?  TextStyle(
                          fontFamily: "galaxy",
                          fontWeight: FontWeight.bold,
                          fontSize: (28/360)*MediaQuery.of(context).size.width,//28
                          )
                      :  TextStyle(
                          fontFamily: AppStrings.fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: (25/360)*MediaQuery.of(context).size.width,//25
                          )),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: GetReservationData(
                data: state.hotelsReservationByUser, type: "user"),
          );

        case RequestState.error:
          BlocProvider.of<HotelsBloc>(context).add(
              GetHotelsReservationByUserEvent(
                  userId: int.parse(
                      sharedPreferences!.getString("USERID") ?? "0")));
          return const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()));
      }
    }));
  }
}
