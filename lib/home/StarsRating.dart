import 'package:fayoumtour/TourismPlaces/presentation/controller/tourism_place_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../TourismPlaces/domain/entities/tourism_place_rate.dart';
import '../TourismPlaces/presentation/controller/tourism_place_bloc.dart';
import '../TourismPlaces/presentation/controller/tourism_place_state.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/enums.dart';
import '../core/utils/snackbar_message.dart';
import '../hotels/domain/entities/hotel_rate.dart';
import '../hotels/presentation/controller/hotels_bloc.dart';
import '../hotels/presentation/controller/hotels_event.dart';
import '../hotels/presentation/controller/hotels_state.dart';

class RatingScreen extends StatefulWidget {
  String type;
  String data;
  int id;
  RatingScreen(
      {Key? key, required this.type, required this.data, required this.id})
      : super(key: key);
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _rating = 0;

  void _onRated(int rating) {
    setState(() {
      _rating = rating;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rating submitted'),
          content: Text('You rated this app $_rating stars.'),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text('OK')),
            ),
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StarRating(
      // data: widget.data,
      // rating: _rating,
      type: widget.type,
      id: widget.id,
      rating: int.parse(widget.data),
      onRated: _onRated,
    );
  }
}

class StarRating extends StatelessWidget {
  final int rating;
  int id;
  String type;
  final Function(int)? onRated;

  StarRating(
      {super.key,
      this.rating = 0,
      this.onRated,
      required this.id,
      required this.type});

  Widget _buildStar(BuildContext context, int index) {
    IconData iconData = Icons.star_border;
    Color color = Colors.grey;

    if (index < rating) {
      iconData = Icons.star;
      color = Colors.amber;
    }

    return GestureDetector(
      onTap: () {
        print(index + 1);
        onRated!(index + 1);
        if (type == "places") {
          TourismPlaceRate tourismPlaceRate = TourismPlaceRate(
              stars: (index + 1),
              user: int.parse(sharedPreferences!.getString("USERID") ?? "0"));
          BlocProvider.of<TourismPlaceBloc>(context).add(
              UpdateCreateTourismPlaceRatesEvent(
                  updateCreateTourRate: tourismPlaceRate,
                  tourismPlaceID: id.toString()));
        } else {
          HotelRate hotelRate = HotelRate(
              stars: (index + 1),
              user: int.parse(sharedPreferences!.getString("USERID") ?? "0"));
          BlocProvider.of<HotelsBloc>(context).add(UpdateCreateHotelRatesEvent(
              updateCreateHotelRate: hotelRate, hotelID: id.toString()));
        }
      },
      child: Icon(
        iconData,
        color: color,
        size: 30,
      ),
    );

    // return Container();
  }

  @override
  Widget build(BuildContext context) {
    return type == "places"
        ? BlocConsumer<TourismPlaceBloc, TourismPlaceState>(
            listener: (context, state) {
            if (state.updateCreateTourismPlaceRateState ==
                RequestState.loaded) {
              print("Loded");
            } else if (state.updateCreateTourismPlaceRateState ==
                RequestState.loading) {
              print("Loding");
            } else if (state.updateCreateTourismPlaceRateState ==
                RequestState.error) {
              SnackBarMessage().showErrorSnackBar(
                  message: state.updateCreateTourismPlaceRateMessage,
                  context: context);
            }
          }, builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Rating "),
                for (int i = 0; i < 5; i++) _buildStar(context, i),
              ],
            );
          })
        : BlocConsumer<HotelsBloc, HotelsState>(listener: (context, state) {
            if (state.updateCreateHotelRateState == RequestState.loaded) {
              print("Loded");
            } else if (state.updateCreateHotelRateState ==
                RequestState.loading) {
              print("Loding");
            } else if (state.updateCreateHotelRateState == RequestState.error) {
              SnackBarMessage().showErrorSnackBar(
                  message: state.updateCreateHotelRateMessage,
                  context: context);
            }
          }, builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Rating "),
                for (int i = 0; i < 5; i++) _buildStar(context, i),
              ],
            );
          });
    ;
  }
}