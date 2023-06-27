import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';
import '../controller/hotels_bloc.dart';
import '../controller/hotels_event.dart';
import '../controller/hotels_state.dart';

class HotelsReservationDetailsForManager extends StatelessWidget {
  HotelsReservationDetailsForManager({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      return getIt<HotelsBloc>()..add(GetHotelsReservationEvent(hotelId: 4));
    }, child: BlocBuilder<HotelsBloc, HotelsState>(builder: (context, state) {
      switch (state.hotelReservationState) {
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
                        itemCount: state.hotelsReservation.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final hotelsReservation =
                              state.hotelsReservation[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${hotelsReservation.phone_number}"),
                              Text("${hotelsReservation.adulls}"),
                              Text("${hotelsReservation.kids}"),
                              Text("${hotelsReservation.check_in}"),
                              Text("${hotelsReservation.check_out}"),
                              Text("${hotelsReservation.createdBy!.email}"),
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
