import 'package:fayoumtour/home/reserve.dart';
import 'package:fayoumtour/hotels/presentation/controller/hotels_bloc.dart';
import 'package:fayoumtour/hotels/presentation/controller/hotels_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/utils/app_localizations.dart';
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
    return data.length == 0
        ? Center(
            child: Text(
              // "Nothing Yet",
              AppLocalizations.of(context)!.translate("Nothing Yet"),
              style: TextStyle(
                  fontFamily: sharedPreferences!.getString("Language") == "AR" ? "aref" :"pressStart2p",
                  fontSize: sharedPreferences!.getString("Language") == "AR" ?38:24,
                  color: Theme.of(context).colorScheme.primary),
            ),
          )
        : ListView.builder(
            itemCount: data.length,
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
                          Expanded(
                            child: Text(
                              type == "user"
                                  ? sharedPreferences!.getString("Language") ==
                                          "AR"
                                      ? data[index].hotelNameAR
                                      : data[index].hotelName
                                  : data[index].createdBy.userName,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
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
                                                      hotelId:
                                                          data[index].hotel,
                                                      type: "edit",
                                                      data: data[index],
                                                    )));
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.cancel),
                                      onPressed: () {
                                        // Implement cancellation logic here
                                        BlocProvider.of<HotelsBloc>(context)
                                            .add(DeleteHotelReservationEvent(
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
                              Text(
                                  AppLocalizations.of(context)!
                                      .translate("Reservation for"),
                                  style: sharedPreferences!.getString("Language") == "AR"
                                          ? const TextStyle(
                                          fontFamily: "messiri", fontSize: 16.5)
                                          : const TextStyle(
                                          fontFamily: "acme", fontSize: 16.5),
                                      
                                      ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                                      style: sharedPreferences!.getString("Language") == "AR"
                                          ? const TextStyle(
                                          fontFamily: "messiri",
                                          fontSize: 17,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold)
                                          : const TextStyle(
                                          fontFamily: "acme",
                                          fontSize: 17,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      data[index].adulls == 1
                                          ? AppLocalizations.of(context)!
                                              .translate(" Adult")
                                          : AppLocalizations.of(context)!
                                              .translate("adults"),
                                      style: sharedPreferences!.getString("Language") == "AR"
                                          ? const TextStyle(
                                          fontFamily: "messiri", fontSize: 16.5)
                                          : const TextStyle(
                                          fontFamily: "acme", fontSize: 16.5),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                  AppLocalizations.of(context)!
                                      .translate("and"),
                                  style: sharedPreferences!.getString("Language") == "AR"
                                          ? const TextStyle(
                                          fontFamily: "messiri", fontSize: 16.5)
                                          : const TextStyle(
                                          fontFamily: "acme", fontSize: 16.5),
                                      ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                                      style: TextStyle(
                                          fontFamily: "messiri",
                                          fontSize:
                                              data[index].kids == 0 ? 16.5 : 17,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      data[index].kids == 1
                                          ? AppLocalizations.of(context)!
                                              .translate(" Kid")
                                          : AppLocalizations.of(context)!
                                              .translate("kids"),
                                      style: const TextStyle(
                                          fontFamily: "messiri", fontSize: 16.5),
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
                                  Text(
                                      AppLocalizations.of(context)!
                                          .translate("Check-In"),
                                      style: sharedPreferences!.getString("Language") == "AR"
                                          ? const TextStyle(
                                          fontFamily: "messiri", fontSize: 16)
                                          : const TextStyle(
                                          fontFamily: "acme", fontSize: 16),
                                          ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: 30,
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
                                        data[index].check_in,
                                        style: const TextStyle(
                                            fontFamily: "acme",
                                            fontSize: 18,
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
                                    style: sharedPreferences!.getString("Language") == "AR"
                                          ? const TextStyle(
                                          fontFamily: "messiri", fontSize: 16)
                                          : const TextStyle(
                                          fontFamily: "acme", fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: 30,
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
                                        data[index].check_out,
                                        style: const TextStyle(
                                            fontFamily: "acme",
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
                                    AppLocalizations.of(context)!
                                        .translate("Request Time"),
                                    style: sharedPreferences!.getString("Language") == "AR"
                                          ? const TextStyle(
                                          fontFamily: "messiri", fontSize: 16)
                                          : const TextStyle(
                                          fontFamily: "acme", fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: 50,
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
                                            data[index]
                                                .created_at
                                                .substring(0, 10),
                                            style: const TextStyle(
                                                fontFamily: "acme",
                                                fontSize: 17,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // Text(
                                          //   ' | ',
                                          //   style: GoogleFonts.acme(fontSize: 17),
                                          // ),
                                          Text(
                                            data[index]
                                                .created_at
                                                .substring(12, 16),
                                            style: const TextStyle(
                                                fontFamily: "acme",
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
                                    AppLocalizations.of(context)!
                                        .translate("Phone Number"),
                                    style: sharedPreferences!.getString("Language") == "AR"
                                          ? const TextStyle(
                                          fontFamily: "messiri", fontSize: 16)
                                          : const TextStyle(
                                          fontFamily: "acme", fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: 50,
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
                                          child: Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            data[index].phone_number,
                                            style: const TextStyle(
                                                fontFamily: "acme",
                                                fontSize: 17,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
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
