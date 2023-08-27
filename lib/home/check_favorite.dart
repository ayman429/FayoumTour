// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../core/local_data_shared_preferences/favourites_shared_preferences.dart';
import '../core/utils/app_localizations.dart';
import '../core/utils/constance/shared_pref.dart';

// ignore: must_be_immutable
class CheckFavorite extends StatefulWidget {
  
  var data;
  String type;
  CheckFavorite({
    Key? key,
    required this.data,
    required this.type,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<CheckFavorite> createState() => _CheckFavoriteState(data, type);
}

class _CheckFavoriteState extends State<CheckFavorite> {
  var newData;
  var typeVal;
  _CheckFavoriteState(data, type) {
    newData = data;
    typeVal = type;
  }
  var flag;
  // @override
  // void initState() {
  //   super.initState();
  //   FavouritStorage().searchFavourit(newData).then((value) => setState(() {
  //         flag = value;
  //         print("flag===--===> $flag");
  //       }));
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: FavouritStorage().searchFavourit(newData),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          flag = snapshot.data;

          return Container(
            margin: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () async {
                if (await FavouritStorage().searchFavourit(newData) == true) {
                  FavouritStorage().deleteFavourit(newData.name);
                  setState(() {
                    flag = false;
                  });
                } else if (await FavouritStorage().searchFavourit(newData) ==
                    false) {
                  await FavouritStorage().saveFavourits(newData, typeVal);
                  setState(() {
                    flag = true;
                  });

                  // ignore: use_build_context_synchronously
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            AppLocalizations.of(context)!
                                .translate("Adding Successful"),
                            style: sharedPreferences!.getString("Language") ==
                                    "AR"
                                ? const TextStyle(fontFamily: "messiri")
                                : const TextStyle(fontFamily: "merriweather"),
                          ),
                          actions: [
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .translate("Okay"),
                                      style: TextStyle(
                                          fontFamily: sharedPreferences!
                                                      .getString("Language") ==
                                                  "AR"
                                              ? "Mag"
                                              : "rye",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary))),
                            )
                          ],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        );
                      });
                }
              },
              icon: (flag)
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size:
                          (40 / 360) * MediaQuery.of(context).size.width, //40,
                    )
                  : Icon(
                      Icons.favorite_border_rounded,
                      color: Colors.red,
                      size:
                          (40 / 360) * MediaQuery.of(context).size.width, //40,
                    ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
