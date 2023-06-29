import 'package:fayoumtour/home/reserve.dart';
import 'package:fayoumtour/hotels/presentation/controller/hotels_bloc.dart';
import 'package:fayoumtour/hotels/presentation/controller/hotels_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';

class GetReservationData extends StatelessWidget {
  dynamic data;
  String type;
  GetReservationData({
    Key? key,
    required this.data,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return ListView.builder(
      itemCount: data.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4.0,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: type == "user"
                                  ? Image.network(
                                      data[index].hotelImage,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          AppStrings.error1Gif,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress != null) {
                                          return Image.asset(
                                            AppStrings.loading1Gif,
                                            fit: BoxFit.cover,
                                          );
                                        }
                                        return child;
                                      },
                                    )
                                  : data[index].createdBy.image != ""
                                      ? Image.network(
                                          data[index].createdBy.image,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              AppStrings.error1Gif,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress != null) {
                                              return Image.asset(
                                                AppStrings.loading1Gif,
                                                fit: BoxFit.cover,
                                              );
                                            }
                                            return child;
                                          },
                                        )
                                      : Image.asset(
                                          AppStrings.profileImage,
                                          fit: BoxFit.cover,
                                        )),
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          type == "user"
                              ? data[index].hotelName
                              : data[index].createdBy.userName,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    type == "user"
                        ? Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  // Implement cancellation logic here
                                  //edit
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HotelReservationScreen(
                                                hotelId: data[index].hotel,
                                                type: "edit",
                                                data: data[index],
                                              )));
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () {
                                  // Implement cancellation logic here
                                  BlocProvider.of<HotelsBloc>(context).add(
                                      DeleteHotelReservationEvent(
                                          hotelsId: data[index].id));
                                  // BlocProvider.of<HotelsBloc>(context).add(
                                  //     GetHotelsReservationByUserEvent(
                                  //         userId: int.parse(sharedPreferences!
                                  //                 .getString("USERID") ??
                                  //             "0")));
                                },
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      children: [
                        Text('Reservation for',
                            style: GoogleFonts.acme(fontSize: 16)),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2,
                                  //offset: Offset(4,4),
                                ),
                              ]),
                          height: 30,
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${data[index].adulls}",
                                style: GoogleFonts.acme(
                                    fontSize: 17,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                " Adults",
                                style: GoogleFonts.acme(fontSize: 16.5),
                              ),
                            ],
                          ),
                        ),
                        Text('and', style: GoogleFonts.acme(fontSize: 16)),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2,
                                  //offset: Offset(4,4),
                                ),
                              ]),
                          height: 30,
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${data[index].kids}",
                                style: GoogleFonts.acme(
                                    fontSize: 17,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                " Kids",
                                style: GoogleFonts.acme(fontSize: 16.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Check-In Date",
                                style: GoogleFonts.acme(fontSize: 16)),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width * 0.35,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiaryContainer,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2,
                                        //offset: Offset(4,4),
                                      ),
                                    ]),
                                child: Center(
                                    child: Text(
                                  data[index].check_in,
                                  style: GoogleFonts.acme(
                                      fontSize: 18,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ))),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Check-Out Date",
                              style: GoogleFonts.acme(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width * 0.35,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiaryContainer,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2,
                                        //offset: Offset(4,4),
                                      ),
                                    ]),
                                child: Center(
                                    child: Text(
                                  data[index].check_out,
                                  style: GoogleFonts.acme(
                                      fontSize: 18,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ))),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Request Time",
                              style: GoogleFonts.acme(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width * 0.35,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiaryContainer,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2,
                                        //offset: Offset(4,4),
                                      ),
                                    ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data[index].created_at.substring(0, 10),
                                      style: GoogleFonts.acme(
                                          fontSize: 17,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' | ',
                                      style: GoogleFonts.acme(fontSize: 17),
                                    ),
                                    Text(
                                      data[index].created_at.substring(12, 16),
                                      style: GoogleFonts.acme(
                                          fontSize: 17,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Phone Number",
                              style: GoogleFonts.acme(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width * 0.35,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiaryContainer,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2,
                                        //offset: Offset(4,4),
                                      ),
                                    ]),
                                child: Center(
                                    child: Text(
                                  data[index].phone_number,
                                  style: GoogleFonts.acme(
                                      fontSize: 18,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ))),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
