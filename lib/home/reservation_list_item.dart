import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fayoumtour/home/QR.dart';
import 'package:fayoumtour/home/reserve.dart';
import 'package:fayoumtour/hotels/presentation/controller/hotels_bloc.dart';
import 'package:fayoumtour/hotels/presentation/controller/hotels_event.dart';

import '../core/services/services_locator.dart';
import '../core/utils/app_localizations.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';
import '../core/utils/enums.dart';
import '../hotels/domain/entities/hotel_reservation.dart';
import '../hotels/presentation/controller/hotels_state.dart';

class ReservationListItem extends StatelessWidget {
  Map<String, dynamic> data;
  ReservationListItem({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
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
                      child: data["USERIMAGE"] != ""
                          ? Image.network(
                              data["USERIMAGE"],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
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
                          : Image.asset(
                              AppStrings.profileImage,
                              fit: BoxFit.cover,
                            )),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    data["username"],
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
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
                          : const TextStyle(fontFamily: "acme", fontSize: 16.5),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // margin:
                      //     const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              //offset: Offset(4,4),
                            ),
                          ]),
                      height: 30,
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${data["adulls"]}",
                            style:
                                sharedPreferences!.getString("Language") == "AR"
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
                            data["adulls"] == 1
                                ? AppLocalizations.of(context)!
                                    .translate(" Adult")
                                : AppLocalizations.of(context)!
                                    .translate("adults"),
                            style:
                                sharedPreferences!.getString("Language") == "AR"
                                    ? const TextStyle(
                                        fontFamily: "messiri", fontSize: 16.5)
                                    : const TextStyle(
                                        fontFamily: "acme", fontSize: 16.5),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.translate("and"),
                      style: sharedPreferences!.getString("Language") == "AR"
                          ? const TextStyle(
                              fontFamily: "messiri", fontSize: 16.5)
                          : const TextStyle(fontFamily: "acme", fontSize: 16.5),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              //offset: Offset(4,4),
                            ),
                          ]),
                      height: 30,
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${data["kids"]}",
                            style: TextStyle(
                                fontFamily: "messiri",
                                fontSize: data["kids"] == 0 ? 16.5 : 17,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data["kids"] == 1
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
                          AppLocalizations.of(context)!.translate("Check-In"),
                          style:
                              sharedPreferences!.getString("Language") == "AR"
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
                              data["check_in"],
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
                          AppLocalizations.of(context)!.translate("Check-Out"),
                          style:
                              sharedPreferences!.getString("Language") == "AR"
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
                              data["check_out"],
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
                          style:
                              sharedPreferences!.getString("Language") == "AR"
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data["date"],
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
                                  data["Time"],
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
                          style:
                              sharedPreferences!.getString("Language") == "AR"
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
                                child: Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  data["phone_number"],
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
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.translate("Status"),
                      style: sharedPreferences!.getString("Language") == "AR"
                          ? const TextStyle(fontFamily: "messiri", fontSize: 16)
                          : const TextStyle(fontFamily: "acme", fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.65,
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
                          sharedPreferences!.getString("Language") == "AR"
                              ? data["status"] == "under review"
                                  ? "قيد المراجعة"
                                  : data["status"] == "Accept"
                                      ? "تم القبول"
                                      : data["status"] == "Reject"
                                          ? "تم الرفض"
                                          : "قيد المراجعة"
                              : "${data["status"]}",
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
          ],
        ),
      ),
    );
  }
}