import 'package:cached_network_image/cached_network_image.dart';
import 'package:fayoumtour/home/QR.dart';
import 'package:fayoumtour/home/reserve.dart';
import 'package:fayoumtour/hotels/presentation/controller/hotels_bloc.dart';
import 'package:fayoumtour/hotels/presentation/controller/hotels_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/notification/add_notification.dart';
import '../core/services/services_locator.dart';
import '../core/utils/app_localizations.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';
import '../core/utils/enums.dart';
import '../hotels/domain/entities/hotel_reservation.dart';
import '../hotels/presentation/controller/hotels_state.dart';

class GetReservationData extends StatefulWidget {
  final dynamic data;
  final String type;
  const GetReservationData({
    Key? key,
    required this.data,
    required this.type,
  }) : super(key: key);

  @override
  State<GetReservationData> createState() => _GetReservationDataState();
}

class _GetReservationDataState extends State<GetReservationData> {
  bool reject = false;
  bool accept = false;
  @override
  Widget build(BuildContext context) {
    return widget.data.length == 0
        ? Center(
            child: Text(
              // "Nothing Yet",
              AppLocalizations.of(context)!.translate("Nothing Yet"),
              style: TextStyle(
                  fontFamily: sharedPreferences!.getString("Language") == "AR"
                      ? "aref"
                      : "pressStart2p",
                  fontSize: sharedPreferences!.getString("Language") == "AR"
                      ? (38 / 360) * MediaQuery.of(context).size.width //38
                      : (24 / 360) * MediaQuery.of(context).size.width, //24,
                  color: Theme.of(context).colorScheme.primary),
            ),
          )
        : ListView.builder(
            itemCount: widget.data.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: (50 / 360) *
                                MediaQuery.of(context).size.width, //50,
                            height: (50 / 360) *
                                MediaQuery.of(context).size.width, //50,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: widget.type == "user"
                                    ? CachedNetworkImage(
                                        imageUrl: widget.data[index].hotelImage,
                                        fadeInDuration:
                                            const Duration(milliseconds: 300),
                                        fadeOutDuration:
                                            const Duration(milliseconds: 50),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) {
                                          return Image.asset(
                                            AppStrings.profileImage,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                        errorWidget: (context, url, error) {
                                          return Image.asset(
                                            AppStrings.error1Gif,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      )
                                    // Image.network(
                                    //     data[index].hotelImage,
                                    //     fit: BoxFit.cover,
                                    //     errorBuilder:
                                    //         (context, error, stackTrace) {
                                    //       return Image.asset(
                                    //         AppStrings.error1Gif,
                                    //         fit: BoxFit.cover,
                                    //       );
                                    //     },
                                    //     loadingBuilder:
                                    //         (context, child, loadingProgress) {
                                    //       if (loadingProgress != null) {
                                    //         return Image.asset(
                                    //           AppStrings.loading1Gif,
                                    //           fit: BoxFit.cover,
                                    //         );
                                    //       }
                                    //       return child;
                                    //     },
                                    //   )
                                    : widget.data[index].createdBy.image != ""
                                        ? CachedNetworkImage(
                                            imageUrl: widget
                                                .data[index].createdBy.image,
                                            fadeInDuration: const Duration(
                                                milliseconds: 300),
                                            fadeOutDuration: const Duration(
                                                milliseconds: 50),
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) {
                                              return Image.asset(
                                                AppStrings.profileImage,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                            errorWidget: (context, url, error) {
                                              return Image.asset(
                                                AppStrings.error1Gif,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          )
                                        // Image.network(
                                        //     data[index].createdBy.image,
                                        //     fit: BoxFit.cover,
                                        //     errorBuilder:
                                        //         (context, error, stackTrace) {
                                        //       return Image.asset(
                                        //         AppStrings.error1Gif,
                                        //         fit: BoxFit.cover,
                                        //       );
                                        //     },
                                        //     loadingBuilder: (context, child,
                                        //         loadingProgress) {
                                        //       if (loadingProgress != null) {
                                        //         return Image.asset(
                                        //           AppStrings.loading1Gif,
                                        //           fit: BoxFit.cover,
                                        //         );
                                        //       }
                                        //       return child;
                                        //     },
                                        //   )
                                        : Image.asset(
                                            AppStrings.profileImage,
                                            fit: BoxFit.cover,
                                          )),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              widget.type == "user"
                                  ? sharedPreferences!.getString("Language") ==
                                          "AR"
                                      ? widget.data[index].hotelNameAR
                                      : widget.data[index].hotelName
                                  : widget.data[index].createdBy.userName,
                              style: TextStyle(
                                  fontSize: (18 / 360) *
                                      MediaQuery.of(context).size.width, //18.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "ibmP"),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          widget.type == "user"
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
                                                      hotelId: widget
                                                          .data[index].hotel,
                                                      type: "edit",
                                                      data: widget.data[index],
                                                    )));
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.cancel),
                                      onPressed: () {
                                        // Implement cancellation logic here
                                        BlocProvider.of<HotelsBloc>(context)
                                            .add(DeleteHotelReservationEvent(
                                                hotelsId:
                                                    widget.data[index].id));
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate("Reservation for"),
                                    style: sharedPreferences!
                                                .getString("Language") ==
                                            "AR"
                                        ? TextStyle(
                                            fontFamily: "messiri",
                                            fontSize: (16.5 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //16.5
                                          )
                                        : TextStyle(
                                            fontFamily: "acme",
                                            fontSize: (16.5 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //16.5
                                          ),
                                  ),
                                  sharedPreferences!.getString("Language") ==
                                          "AR"
                                      ? const SizedBox(
                                          width: 2,
                                        )
                                      : const SizedBox(
                                          width: 3,
                                        ),
                                  Container(
                                    // margin: sharedPreferences!.getString("Language") == "AR"
                                    // ? const EdgeInsets.only(right: 1, left: 4)
                                    // : const EdgeInsets.only(left: 1, right: 4),
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
                                    height: (30 / 772) *
                                        MediaQuery.of(context)
                                            .size
                                            .height, //30,
                                    width: sharedPreferences!
                                                .getString("Language") ==
                                            "AR"
                                        ? MediaQuery.of(context).size.width *
                                            0.33
                                        : MediaQuery.of(context).size.width *
                                            0.22,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${widget.data[index].adulls}",
                                          style: sharedPreferences!
                                                      .getString("Language") ==
                                                  "AR"
                                              ? TextStyle(
                                                  fontFamily: "messiri",
                                                  fontSize: (17 / 360) *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width, //17,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)
                                              : TextStyle(
                                                  fontFamily: "acme",
                                                  fontSize: (17 / 360) *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width, //17,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          widget.data[index].adulls == 1
                                              ? AppLocalizations.of(context)!
                                                  .translate(" Adult")
                                              : AppLocalizations.of(context)!
                                                  .translate("adults"),
                                          style: sharedPreferences!
                                                      .getString("Language") ==
                                                  "AR"
                                              ? TextStyle(
                                                  fontFamily: "messiri",
                                                  fontSize: (16.5 / 360) *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width, //16.5
                                                )
                                              : TextStyle(
                                                  fontFamily: "acme",
                                                  fontSize: (16.5 / 360) *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width, //16.5
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate("and"),
                                    style: sharedPreferences!
                                                .getString("Language") ==
                                            "AR"
                                        ? TextStyle(
                                            fontFamily: "messiri",
                                            fontSize: (16.5 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //16.5
                                          )
                                        : TextStyle(
                                            fontFamily: "acme",
                                            fontSize: (16.5 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //16.5
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    //margin:const EdgeInsets.symmetric(horizontal: 4),
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
                                    height: (30 / 772) *
                                        MediaQuery.of(context)
                                            .size
                                            .height, //30,
                                    width: sharedPreferences!
                                                .getString("Language") ==
                                            "AR"
                                        ? MediaQuery.of(context).size.width *
                                            0.33
                                        : MediaQuery.of(context).size.width *
                                            0.22,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${widget.data[index].kids}",
                                          style: TextStyle(
                                              fontFamily: sharedPreferences!
                                                          .getString(
                                                              "Language") ==
                                                      "AR"
                                                  ? "messiri"
                                                  : "acme",
                                              fontSize:
                                                  widget.data[index].kids == 0
                                                      ? (16.5 / 360) *
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width //16.5
                                                      : (17 / 360) *
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width, //17,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          widget.data[index].kids == 1
                                              ? AppLocalizations.of(context)!
                                                  .translate(" Kid")
                                              : AppLocalizations.of(context)!
                                                  .translate("kids"),
                                          style: TextStyle(
                                            fontFamily: sharedPreferences!
                                                        .getString(
                                                            "Language") ==
                                                    "AR"
                                                ? "messiri"
                                                : "acme",
                                            fontSize: (16.5 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //16.5
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                    AppLocalizations.of(context)!
                                        .translate("Check-In"),
                                    style: sharedPreferences!
                                                .getString("Language") ==
                                            "AR"
                                        ? TextStyle(
                                            fontFamily: "messiri",
                                            fontSize: (16 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //16
                                          )
                                        : TextStyle(
                                            fontFamily: "acme",
                                            fontSize: (16 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //16
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: (30 / 772) *
                                          MediaQuery.of(context)
                                              .size
                                              .height, //30,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 2,
                                              //offset: Offset(4,4),
                                            ),
                                          ]),
                                      child: Center(
                                          child: Text(
                                        widget.data[index].check_in,
                                        style: TextStyle(
                                            fontFamily: "acme",
                                            fontSize: (16 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //18,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ))),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate("Check-Out"),
                                    style: sharedPreferences!
                                                .getString("Language") ==
                                            "AR"
                                        ? TextStyle(
                                            fontFamily: "messiri",
                                            fontSize: (16 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //16
                                          )
                                        : TextStyle(
                                            fontFamily: "acme",
                                            fontSize: (16 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //16
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: (30 / 772) *
                                          MediaQuery.of(context)
                                              .size
                                              .height, //30,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 2,
                                              //offset: Offset(4,4),
                                            ),
                                          ]),
                                      child: Center(
                                          child: Text(
                                        widget.data[index].check_out,
                                        style: TextStyle(
                                            fontFamily: "acme",
                                            fontSize: (16 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //18,
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
                                    AppLocalizations.of(context)!
                                        .translate("Request Time"),
                                    style: sharedPreferences!
                                                .getString("Language") ==
                                            "AR"
                                        ? TextStyle(
                                            fontFamily: "messiri",
                                            fontSize: (16 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //16
                                          )
                                        : TextStyle(
                                            fontFamily: "acme",
                                            fontSize: (16 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //16
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: (50 / 772) *
                                          MediaQuery.of(context)
                                              .size
                                              .height, //50,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 2,
                                              //offset: Offset(4,4),
                                            ),
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            widget.data[index].created_at
                                                .substring(0, 10),
                                            style: TextStyle(
                                                fontFamily: "acme",
                                                fontSize: (14 / 360) *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width, //17,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // Text(
                                          //   ' | ',
                                          //   style: GoogleFonts.acme(fontSize: 17),
                                          // ),
                                          Text(
                                            widget.data[index].created_at
                                                .substring(11, 16),
                                            style: TextStyle(
                                                fontFamily: "acme",
                                                fontSize: (14 / 360) *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width, //17,
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
                                    AppLocalizations.of(context)!
                                        .translate("Phone Number"),
                                    style: sharedPreferences!
                                                .getString("Language") ==
                                            "AR"
                                        ? TextStyle(
                                            fontFamily: "messiri",
                                            fontSize: (16 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //16
                                          )
                                        : TextStyle(
                                            fontFamily: "acme",
                                            fontSize: (16 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //16
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: (50 / 772) *
                                          MediaQuery.of(context)
                                              .size
                                              .height, //50,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 2,
                                              //offset: Offset(4,4),
                                            ),
                                          ]),
                                      child: Center(
                                          child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            widget.data[index].phone_number,
                                            style: TextStyle(
                                                fontFamily: "acme",
                                                fontSize: (15 / 360) *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width, //17,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .translate("Status"),
                                style:
                                    sharedPreferences!.getString("Language") ==
                                            "AR"
                                        ? TextStyle(
                                            fontFamily: "messiri",
                                            fontSize: (16 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //16
                                          )
                                        : TextStyle(
                                            fontFamily: "acme",
                                            fontSize: (16 / 360) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width, //16
                                          ),
                              ),
                              //const SizedBox(height: 2,),
                              widget.type == "user" &&
                                      widget.data[index].status == "Accept"
                                  ? Row(
                                      children: [
                                        Container(
                                            height: (40 / 772) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .height, //40,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onTertiaryContainer,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 2,
                                                    //offset: Offset(4,4),
                                                  ),
                                                ]),
                                            child: Center(
                                                child: Text(
                                              sharedPreferences!.getString(
                                                          "Language") ==
                                                      "AR"
                                                  ? widget.data[index].status ==
                                                          "Under Review"
                                                      ? "قيد المراجعة"
                                                      : widget.data[index]
                                                                  .status ==
                                                              "Accept"
                                                          ? "تم القبول"
                                                          : widget.data[index]
                                                                      .status ==
                                                                  "Reject"
                                                              ? "تم الرفض"
                                                              : "قيد المراجعة"
                                                  : "${widget.data[index].status}",
                                              style: sharedPreferences!
                                                          .getString(
                                                              "Language") ==
                                                      "AR"
                                                  ? TextStyle(
                                                      fontFamily: "messiri",
                                                      fontSize: (17 / 360) *
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width, //18,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold)
                                                  : TextStyle(
                                                      fontFamily: "acme",
                                                      fontSize: (17 / 360) *
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width, //18,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ))),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                // BoxShadow(
                                                //   color: Colors.grey,
                                                //   blurRadius: 2,
                                                //   //offset: Offset(4,4),
                                                // ),
                                              ]),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => QR(
                                                        data:
                                                            widget.data[index]),
                                                  ));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.5,
                                                        horizontal: 13),
                                                child: Icon(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  Icons.qr_code,
                                                  size: (30 / 360) *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width, //30,
                                                )
                                                // Text(
                                                //   AppLocalizations.of(context)!.translate("Get QR"),
                                                //   style: TextStyle(
                                                //       fontFamily: sharedPreferences!
                                                //                   .getString("Language") ==
                                                //               "AR"
                                                //           ? "Mag"
                                                //           : "rye",
                                                //       color: Theme.of(context)
                                                //           .colorScheme
                                                //           .secondary,
                                                //       fontSize: 17),
                                                // ),
                                                ),
                                          ),
                                        )
                                      ],
                                    )
                                  : widget.type != "user" &&
                                          widget.data[index].status !=
                                              "Accept" &&
                                          widget.data[index].status != "Reject"
                                      ? Row(
                                          children: [
                                            Container(
                                                height: (40 / 772) *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height, //40,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.40,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onTertiaryContainer,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 2,
                                                        //offset: Offset(4,4),
                                                      ),
                                                    ]),
                                                child: Center(
                                                    child: Text(
                                                  sharedPreferences!.getString(
                                                              "Language") ==
                                                          "AR"
                                                      ? widget.data[index]
                                                                  .status ==
                                                              "under review"
                                                          ? "قيد المراجعة"
                                                          : widget.data[index]
                                                                      .status ==
                                                                  "Accept"
                                                              ? "تم القبول"
                                                              : widget.data[index]
                                                                          .status ==
                                                                      "Reject"
                                                                  ? "تم الرفض"
                                                                  : "قيد المراجعة"
                                                      : "${widget.data[index].status}",
                                                  style: sharedPreferences!
                                                              .getString(
                                                                  "Language") ==
                                                          "AR"
                                                      ? TextStyle(
                                                          fontFamily: "messiri",
                                                          fontSize: (17 / 360) *
                                                              MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width, //18,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold)
                                                      : TextStyle(
                                                          fontFamily: "acme",
                                                          fontSize: (17 / 360) *
                                                              MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width, //18,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ))),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            BlocProvider(
                                              create: (context) =>
                                                  getIt<HotelsBloc>(),
                                              child: BlocConsumer<HotelsBloc,
                                                  HotelsState>(
                                                listener: (context, state) {
                                                  if (state
                                                          .updateHotelReservationState ==
                                                      RequestState.loaded) {
                                                    if (accept) {
                                                      AddNotification()
                                                          .addNotification(
                                                        topics:
                                                            "/topics/ReserveState_EN${widget.data[index].createdBy!.id.toString()}",
                                                        body:
                                                            "Your reservation accepted",
                                                        title:
                                                            "Reservations: ${sharedPreferences!.getString("username")}",
                                                        navigation:
                                                            "UserReservation",
                                                      );
                                                      AddNotification()
                                                          .addNotification(
                                                        topics:
                                                            "/topics/ReserveState_AR${widget.data[index].createdBy!.id.toString()}",
                                                        body: "تم قبول حجزك",
                                                        title:
                                                            "الحجوزات: ${sharedPreferences!.getString("username")}",
                                                        navigation:
                                                            "UserReservation",
                                                      );
                                                    }
                                                    if (reject) {
                                                      AddNotification()
                                                          .addNotification(
                                                        topics:
                                                            "/topics/ReserveState_EN${widget.data[index].createdBy!.id.toString()}",
                                                        body:
                                                            "reservation rejected",
                                                        title:
                                                            "${sharedPreferences!.getString("username")}",
                                                        navigation:
                                                            "UserReservation",
                                                      );
                                                      AddNotification()
                                                          .addNotification(
                                                        // topics:
                                                        //     "/topics/ReserveState_AR${47}",
                                                        topics:
                                                            "/topics/ReserveState_AR${widget.data[index].createdBy!.id.toString()}",
                                                        body: "تم رفض الحجز",
                                                        title:
                                                            "${sharedPreferences!.getString("username")}",
                                                        navigation:
                                                            "UserReservation",
                                                      );
                                                    }
                                                    Navigator.pop(context);

                                                    // Navigator.pop(context);
                                                  } else if (state
                                                          .updateHotelReservationState ==
                                                      RequestState.error) {
                                                    //print("//////////////............../////////");
                                                    //print(state.addHotelReservationMessage);
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                builder: (context, state) {
                                                  final hotelsBloc =
                                                      BlocProvider.of<
                                                          HotelsBloc>(context);

                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            reject = true;
                                                            accept = false;
                                                          });
                                                          showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .translate(
                                                                            "Are you sure to complete this process?"),
                                                                    style: TextStyle(
                                                                        fontFamily: sharedPreferences!.getString("Language") ==
                                                                                "AR"
                                                                            ? "messiri"
                                                                            : "merriweather"),
                                                                  ),
                                                                  actions: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              //print("object object object");
                                                                              Navigator.of(context).pop();
                                                                              showDialog(
                                                                                context: context,
                                                                                barrierDismissible: false,
                                                                                builder: (ctx) => const FractionallySizedBox(
                                                                                  widthFactor: 0.5, // Set the desired width factor (0.0 to 1.0)
                                                                                  child: AlertDialog(
                                                                                    content: SizedBox(
                                                                                      width: double.infinity,
                                                                                      height: 30,
                                                                                      child: Center(
                                                                                        child: CircularProgressIndicator(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );

                                                                              HotelReservation hotelReservation = HotelReservation(
                                                                                status: "Reject",
                                                                                id: widget.data[index].id.toString(),
                                                                              );
                                                                              hotelsBloc.add(UpdateHotelReservationEvent(hotelReservation: hotelReservation));
                                                                            },
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              backgroundColor: Colors.green,
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                            ),
                                                                            child: Text(
                                                                              AppLocalizations.of(context)!.translate("Yes"),
                                                                              style: TextStyle(
                                                                                fontFamily: sharedPreferences!.getString("Language") == "AR" ? "Mag" : "rye",
                                                                                color: Theme.of(context).colorScheme.secondary,
                                                                              ),
                                                                            )),
                                                                        ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              backgroundColor: Colors.green,
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                            ),
                                                                            child: Text(
                                                                              AppLocalizations.of(context)!.translate("No"),
                                                                              style: TextStyle(
                                                                                fontFamily: sharedPreferences!.getString("Language") == "AR" ? "Mag" : "rye",
                                                                                color: Theme.of(context).colorScheme.secondary,
                                                                              ),
                                                                            )),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15)),
                                                                );
                                                              });
                                                        },
                                                        style: TextButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.red,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            elevation: 10),
                                                        child: Padding(
                                                          padding: sharedPreferences!
                                                                      .getString(
                                                                          "Language") ==
                                                                  "AR"
                                                              ? const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 4,
                                                                  horizontal:
                                                                      10)
                                                              : const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 4.5,
                                                                  horizontal:
                                                                      6),
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .translate(
                                                                    "Reject"),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  sharedPreferences!
                                                                              .getString("Language") ==
                                                                          "AR"
                                                                      ? "Mag"
                                                                      : "rye",
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                              fontSize: sharedPreferences!
                                                                          .getString(
                                                                              "Language") ==
                                                                      "AR"
                                                                  ? (12 / 360) *
                                                                      MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width //12
                                                                  : (11 / 360) *
                                                                      MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width, //11
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            accept = true;
                                                            reject = false;
                                                          });
                                                          showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .translate(
                                                                            "Are you sure to complete this process?"),
                                                                    style: TextStyle(
                                                                        fontFamily: sharedPreferences!.getString("Language") ==
                                                                                "AR"
                                                                            ? "messiri"
                                                                            : "merriweather"),
                                                                  ),
                                                                  actions: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                              showDialog(
                                                                                context: context,
                                                                                barrierDismissible: false,
                                                                                builder: (ctx) => const FractionallySizedBox(
                                                                                  widthFactor: 0.5, // Set the desired width factor (0.0 to 1.0)
                                                                                  child: AlertDialog(
                                                                                    content: SizedBox(
                                                                                      width: double.infinity,
                                                                                      height: 30,
                                                                                      child: Center(
                                                                                        child: CircularProgressIndicator(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );

                                                                              HotelReservation hotelReservation = HotelReservation(
                                                                                status: "Accept",
                                                                                id: widget.data[index].id.toString(),
                                                                              );
                                                                              hotelsBloc.add(UpdateHotelReservationEvent(hotelReservation: hotelReservation));
                                                                            },
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              backgroundColor: Colors.green,
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                            ),
                                                                            child: Text(
                                                                              AppLocalizations.of(context)!.translate("Yes"),
                                                                              style: TextStyle(
                                                                                fontFamily: sharedPreferences!.getString("Language") == "AR" ? "Mag" : "rye",
                                                                                color: Theme.of(context).colorScheme.secondary,
                                                                              ),
                                                                            )),
                                                                        ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              backgroundColor: Colors.green,
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                            ),
                                                                            child: Text(
                                                                              AppLocalizations.of(context)!.translate("No"),
                                                                              style: TextStyle(
                                                                                fontFamily: sharedPreferences!.getString("Language") == "AR" ? "Mag" : "rye",
                                                                                color: Theme.of(context).colorScheme.secondary,
                                                                              ),
                                                                            )),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15)),
                                                                );
                                                              });
                                                        },
                                                        style: TextButton.styleFrom(
                                                            backgroundColor:
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            elevation: 10),
                                                        child: Padding(
                                                          padding: sharedPreferences!
                                                                      .getString(
                                                                          "Language") ==
                                                                  "AR"
                                                              ? const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 4,
                                                                  horizontal:
                                                                      10)
                                                              : const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 4.5,
                                                                  horizontal:
                                                                      6),
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .translate(
                                                                    "Accept"),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  sharedPreferences!
                                                                              .getString("Language") ==
                                                                          "AR"
                                                                      ? "Mag"
                                                                      : "rye",
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                              fontSize: sharedPreferences!
                                                                          .getString(
                                                                              "Language") ==
                                                                      "AR"
                                                                  ? (12 / 360) *
                                                                      MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width //12
                                                                  : (11 / 360) *
                                                                      MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width, //11
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Container(
                                                height: (40 / 772) *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height, //40,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.820,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onTertiaryContainer,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 2,
                                                        //offset: Offset(4,4),
                                                      ),
                                                    ]),
                                                child: Center(
                                                    child: Text(
                                                  sharedPreferences!.getString(
                                                              "Language") ==
                                                          "AR"
                                                      ? widget.data[index]
                                                                  .status ==
                                                              "Under Review"
                                                          ? "قيد المراجعة"
                                                          : widget.data[index]
                                                                      .status ==
                                                                  "Accept"
                                                              ? "تم القبول"
                                                              : widget.data[index]
                                                                          .status ==
                                                                      "Reject"
                                                                  ? "تم الرفض"
                                                                  : "قيد المراجعة"
                                                      : "${widget.data[index].status}",
                                                  style: sharedPreferences!
                                                              .getString(
                                                                  "Language") ==
                                                          "AR"
                                                      ? TextStyle(
                                                          fontFamily: "messiri",
                                                          fontSize: (17 / 360) *
                                                              MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width, //18,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold)
                                                      : TextStyle(
                                                          fontFamily: "acme",
                                                          fontSize: (17 / 360) *
                                                              MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width, //18,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold),
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
