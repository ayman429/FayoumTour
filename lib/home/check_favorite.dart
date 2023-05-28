import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/local_data_shared_preferences/favourites_shared_preferences.dart';

class CheckFavorite extends StatefulWidget {
  var data;
  String type;
  CheckFavorite({
    Key? key,
    required this.data,
    required this.type,
  }) : super(key: key);

  @override
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

                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Adding Successful",
                            style: GoogleFonts.merriweather(),
                          ),
                          actions: [
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                  child: Text(
                                    "Okay",
                                    style: GoogleFonts.rye(color: Colors.black),
                                  )),
                            )
                          ],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        );
                      });
                }
              },
              icon: (flag)
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 40,
                    )
                  : const Icon(
                      Icons.favorite_border_rounded,
                      color: Colors.red,
                      size: 40,
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
