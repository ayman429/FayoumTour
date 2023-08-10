import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';
import '../../../home/up_bar_image.dart';
import '../controller/hotels_bloc.dart';
import '../controller/hotels_event.dart';
import '../controller/hotels_state.dart';

class HotelsDetails extends StatelessWidget {
  final String hotelsId;
  const HotelsDetails({
    Key? key,
    required this.hotelsId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      return getIt<HotelsBloc>()..add(GetHotelsByIdEvent(hotelsId: hotelsId));
    }, child: BlocBuilder<HotelsBloc, HotelsState>(builder: (context, state) {
      switch (state.hotelStateById) {
        case RequestState.loading:
          return const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()));
        case RequestState.loaded:
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: UpBarImage(data: state.hotelsById, index: 1, type: "hotels"),
          );
        case RequestState.error:
          BlocProvider.of<HotelsBloc>(context)
              .add(GetHotelsByIdEvent(hotelsId: hotelsId));
          return const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()));
      }
    }));
  }
}
