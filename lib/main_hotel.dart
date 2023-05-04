import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/services_locator.dart';
import 'core/utils/enums.dart';
import 'hotels/presentation/controller/hotels_bloc.dart';
import 'hotels/presentation/controller/hotels_event.dart';
import 'hotels/presentation/controller/hotels_state.dart';

void main() {
  ServicesLocator().init();
  runApp(MyApp()); // profile_screen
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return getIt<HotelsBloc>()..add(GetHotelsEvent());
      },
      child: BlocBuilder<HotelsBloc, HotelsState>(builder: (context, state) {
        // print("object");
        // print(state);
        if (state.hotelState == RequestState.loading) {
          print("loading");
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        } else if (state.hotelState == RequestState.loaded) {
          print("loded");
          print(state.hotels.length);
          return MaterialApp(
              home: Scaffold(
                  body: ListView.builder(
            itemCount: state.hotels.length,
            itemBuilder: (context, index) {
              final hotel = state.hotels[index];
              hotel.images2[0].image2;
              return Center(child: Text(hotel.images2[0].image2));
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
        } else if (state.hotelState == RequestState.error) {
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