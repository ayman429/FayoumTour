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

class HotelsReservationDetailsForManager extends StatelessWidget {
  const HotelsReservationDetailsForManager({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      return getIt<HotelsBloc>()
        ..add(GetHotelsReservationEvent(
            hotelId: sharedPreferences!.getInt("managerId") ?? 0));
    }, child: BlocBuilder<HotelsBloc, HotelsState>(builder: (context, state) {
      switch (state.hotelReservationState) {
        case RequestState.loading:
          return const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()));
        case RequestState.loaded:
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.translate("Reservation"),
                style: sharedPreferences!.getString("Language") == "AR"
            ? const TextStyle(
                fontFamily: "galaxy",
                fontWeight: FontWeight.bold,
                fontSize: 28)
            : const TextStyle(
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 25)
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: GetReservationData(
                data: state.hotelsReservation, type: "hotel"),
          );

        case RequestState.error:
          return const Center(child: Text("Error"));
      }
    }));
  }
}
