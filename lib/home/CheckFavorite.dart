import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/local_data_shared_preferences/favourites_shared_preferences.dart';

class checkFav extends StatefulWidget {
  int id;
  // String ro, image;
  // int PlaceType; // 0--->area | 1--->hotel
  checkFav({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<checkFav> createState() => _checkFavState(id);
}

class _checkFavState extends State<checkFav> {
  late int idI;
  _checkFavState(id) {
    this.idI = id;
  }
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: IconButton(
        onPressed: () async {
          setState(() {
            flag = true;
          });
          var l = await FavouritStorage().getFavourits("10");
          if (l.length > 0) {
            for (int i = 0; i < l.length; i++) {}
          } else {}
        },
        // onPressed: () {
        //   if (snapshot.data!.docs.isEmpty) {
        //     FirebaseFirestore.instance.collection("Favourite").add({
        //       "Email": user.email,
        //       "Fav": ro,
        //       "image": image,
        //       "type": (PlaceType == 0) ? "area" : "hotel",
        //     }
        //     );

        //     //Fluttertoast.showToast(msg: "msg",);
        //     //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) =>const DefaultTabController(length: 4, child: BottomBar(select: 1,)))), (route) => false);

        //     showDialog(
        //         context: context,
        //         barrierDismissible: false,
        //         builder: (context) {
        //           return AlertDialog(
        //             title: Text(
        //               "Adding Successful",
        //               style: GoogleFonts.merriweather(),
        //             ),
        //             actions: [
        //               Center(
        //                 child: ElevatedButton(
        //                     onPressed: () {
        //                       Navigator.of(context).pop();
        //                     },
        //                     child: Text(
        //                       "Okay",
        //                       style: GoogleFonts.rye(
        //                           color: Colors.black),
        //                     ),
        //                     style: ElevatedButton.styleFrom(
        //                       primary: Colors.green,
        //                       shape: RoundedRectangleBorder(
        //                           borderRadius:
        //                               BorderRadius.circular(15)),
        //                     )),
        //               )
        //             ],
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(15)),
        //           );
        //         });
        //   } else {
        //     DocumentReference documentReference = FirebaseFirestore
        //         .instance
        //         .collection('Favourite')
        //         .doc(snapshot.data?.docs[0].id);
        //     documentReference.delete();
        //   }
        // },

        icon: flag
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
  }
}
