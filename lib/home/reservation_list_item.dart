import 'package:flutter/material.dart';

import '../core/utils/app_localizations.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';


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
                  width: (50/360)*MediaQuery.of(context).size.width,//50,
                  height: (50/360)*MediaQuery.of(context).size.width,//50,
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
                    style:  TextStyle(
                      fontSize: (18/360)*MediaQuery.of(context).size.width,//18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "ibmP"
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
                                        ?  TextStyle(
                                            fontFamily: "messiri",
                                            fontSize: (16.5/360)*MediaQuery.of(context).size.width,//16.5
                                            )
                                        :  TextStyle(
                                            fontFamily: "acme", fontSize: (16.5/360)*MediaQuery.of(context).size.width,//16.5
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
                                    height: (30/772)*MediaQuery.of(context).size.height,//30,
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
                                          "${data["adulls"]}",
                                          style: sharedPreferences!
                                                      .getString("Language") ==
                                                  "AR"
                                              ?  TextStyle(
                                                  fontFamily: "messiri",
                                                  fontSize: (17/360)*MediaQuery.of(context).size.width,//17,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)
                                              :  TextStyle(
                                                  fontFamily: "acme",
                                                  fontSize: (17/360)*MediaQuery.of(context).size.width,//17,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data["adulls"] == 1
                                              ? AppLocalizations.of(context)!
                                                  .translate(" Adult")
                                              : AppLocalizations.of(context)!
                                                  .translate("adults"),
                                          style: sharedPreferences!
                                                      .getString("Language") ==
                                                  "AR"
                                              ?  TextStyle(
                                                  fontFamily: "messiri",
                                                  fontSize: (16.5/360)*MediaQuery.of(context).size.width,//16.5
                                                  )
                                              :  TextStyle(
                                                  fontFamily: "acme",
                                                  fontSize: (16.5/360)*MediaQuery.of(context).size.width,//16.5
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
                                        ?  TextStyle(
                                            fontFamily: "messiri",
                                            fontSize: (16.5/360)*MediaQuery.of(context).size.width,//16.5
                                            )
                                        :  TextStyle(
                                            fontFamily: "acme", fontSize: (16.5/360)*MediaQuery.of(context).size.width,//16.5
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
                                    height: (30/772)*MediaQuery.of(context).size.height,//30,
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
                                          "${data["kids"]}",
                                          style: TextStyle(
                                              fontFamily: sharedPreferences!
                                                          .getString(
                                                              "Language") ==
                                                      "AR"
                                                  ? "messiri"
                                                  : "acme",
                                              fontSize: data["kids"] == 0
                                                  ? (16.5/360)*MediaQuery.of(context).size.width//16.5
                                                  : (17/360)*MediaQuery.of(context).size.width,//17,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data["kids"] == 1
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
                                              fontSize: (16.5/360)*MediaQuery.of(context).size.width,//16.5
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                Column(
                  
                  children: [
                    
                        
                        
                        Container(
                            height: (30/772)*MediaQuery.of(context).size.height,//30,
                            width: MediaQuery.of(context).size.width * 0.820,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                          AppLocalizations.of(context)!.translate("Check-In"),
                          style:
                              sharedPreferences!.getString("Language") == "AR"
                                  ?  TextStyle(
                                      fontFamily: "messiri", fontSize: (16/360)*MediaQuery.of(context).size.width,//16
                                      )
                                  :  TextStyle(
                                      fontFamily: "acme", fontSize: (16/360)*MediaQuery.of(context).size.width,//16
                                      ),
                        ),
                                Text(
                                  data["check_in"],
                                  style:  TextStyle(
                                      fontFamily: "acme",
                                      fontSize: (18/360)*MediaQuery.of(context).size.width,//18,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                            ),
                    const SizedBox(height: 20),
                    Container(
                            height: (30/772)*MediaQuery.of(context).size.height,//30,
                            width: MediaQuery.of(context).size.width * 0.820,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                          AppLocalizations.of(context)!.translate("Check-Out"),
                          style:
                              sharedPreferences!.getString("Language") == "AR"
                                  ?  TextStyle(
                                      fontFamily: "messiri", fontSize: (16/360)*MediaQuery.of(context).size.width,//16
                                      )
                                  :  TextStyle(
                                      fontFamily: "acme", fontSize: (16/360)*MediaQuery.of(context).size.width,//16
                                      ),
                        ),
                                Text(
                                  data["check_out"],
                                  style:  TextStyle(
                                      fontFamily: "acme",
                                      fontSize: (18/360)*MediaQuery.of(context).size.width,//18,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                            ),
                      
                  ],
                ),
                const SizedBox(height: 20),
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
                                  ?  TextStyle(
                                      fontFamily: "messiri", fontSize: (16/360)*MediaQuery.of(context).size.width,//16
                                      )
                                  :  TextStyle(
                                      fontFamily: "acme", fontSize: (16/360)*MediaQuery.of(context).size.width,//16
                                      ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                            height: (50/772)*MediaQuery.of(context).size.height,//50,
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
                                  style:  TextStyle(
                                      fontFamily: "acme",
                                      fontSize: (17/360)*MediaQuery.of(context).size.width,//17,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                // Text(
                                //   ' | ',
                                //   style: GoogleFonts.acme(fontSize: 17),
                                // ),
                                Text(
                                  data["Time"],
                                  style:  TextStyle(
                                      fontFamily: "acme",
                                      fontSize: (17/360)*MediaQuery.of(context).size.width,//17,
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
                                  ?  TextStyle(
                                      fontFamily: "messiri", fontSize: (16/360)*MediaQuery.of(context).size.width,//16
                                      )
                                  :  TextStyle(
                                      fontFamily: "acme", fontSize: (16/360)*MediaQuery.of(context).size.width,//16
                                      ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                            height: (50/772)*MediaQuery.of(context).size.height,//50,
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
                                  style:  TextStyle(
                                      fontFamily: "acme",
                                      fontSize: (17/360)*MediaQuery.of(context).size.width,//17,
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

            const SizedBox(
                          height: 20,
                        ),

                        Opacity(
                          opacity: 0.4,
                          child: Image.asset(
                            
                            "assets/images/approved.png",
                            height: (300/772)*MediaQuery.of(context).size.height,//300,
                            width: (300/360)*MediaQuery.of(context).size.width,//300,
                            fit: BoxFit.cover,
                            ),
                        )
          ],
        ),
      ),
    );
  }
}
