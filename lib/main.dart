import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'TourismPlaces/presentation/controller/tourism_place_bloc.dart';
import 'TourismPlaces/presentation/controller/tourism_place_event.dart';
import 'TourismPlaces/presentation/controller/tourism_place_state.dart';
import 'core/services/services_locator.dart';
import 'core/utils/enums.dart';

void main() {
  ServicesLocator().init();
  runApp(MyApp()); // profile_screen
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return getIt<TourismPlaceBloc>()..add(GetTourismPlaceEvent());
      },
      child: BlocBuilder<TourismPlaceBloc, TourismPlaceState>(
          builder: (context, state) {
        // print("object");
        // print(state);
        if (state.tourismPlaceState == RequestState.loading) {
          print("loading");
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        } else if (state.tourismPlaceState == RequestState.loaded) {
          print("loded");
          print(state.tourismPlace.length);
          return MaterialApp(
              home: Scaffold(
                  body: ListView.builder(
            itemCount: state.tourismPlace.length,
            itemBuilder: (context, index) {
              final tourismPlace = state.tourismPlace[index];
              return Center(
                  child: Column(
                children: [
                  for (int i = 0; i < tourismPlace.imagesT.length; i++)
                    Text(tourismPlace.imagesT[i].imageT)
                ],
              ));
            },
          )));
          // print("st: ${state.hotelState}");
          // print("hotels:${state.hotels}");
          // state.hotels.map(
          //   (e) {
          //     print(e.name);
          //   },
          // ).toList();
          // return MaterialApp(
          //   home: Scaffold(
          //     appBar: AppBar(),
          //     body: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: const [
          //             Text("Hotels"),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // );
        } else if (state.tourismPlaceState == RequestState.error) {
          print("error");
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: Text("Error")),
            ),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: Text("Error")),
            ),
          );
        }
      }),
    );
  }
}


/*
 print(state.hotels);
        state.hotels.map(
          (e) {
            print(e.email);
          },
        ).toList();

        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text("Ayman")),
          ),
        );
 */