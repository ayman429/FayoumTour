import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';
import '../controller/hotels_bloc.dart';
import '../controller/hotels_event.dart';
import '../controller/hotels_state.dart';

class HotelsReservationDetailsForUser extends StatelessWidget {
  HotelsReservationDetailsForUser({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      return getIt<HotelsBloc>()
        ..add(GetHotelsReservationByUserEvent(userId: 1));
    }, child: BlocBuilder<HotelsBloc, HotelsState>(builder: (context, state) {
      switch (state.hotelReservationByUserState) {
        case RequestState.loading:
          return const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()));
        case RequestState.loaded:
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Scaffold(
              body: Center(
                child: Container(
                    child: ListView.builder(
                        itemCount: state.hotelsReservationByUser.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final hotelsReservationByUser =
                              state.hotelsReservationByUser[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${hotelsReservationByUser.id}"),
                              Text("${hotelsReservationByUser.phone_number}"),
                              Text("${hotelsReservationByUser.adulls}"),
                              Text("${hotelsReservationByUser.kids}"),
                              Text("${hotelsReservationByUser.check_in}"),
                              Text("${hotelsReservationByUser.check_out}"),
                              Text("${hotelsReservationByUser.hotel}"),
                              Text("${hotelsReservationByUser.hotelImage}"),
                              Text("${hotelsReservationByUser.hotelName}"),
                            ],
                          );
                        })),
              ),
            ),
          );
        case RequestState.error:
          return const Center(child: Text("Error"));
      }
    }));
  }
}
