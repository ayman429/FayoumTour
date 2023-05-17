import 'package:fayoumtour/core/utils/constance/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'RatingStarsBar.dart';
import 'image_list.dart';

class Details extends StatelessWidget {
  var data;
  int index;
  Details({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.49,
      padding: const EdgeInsets.only(top: 20, left: 0, right: 0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          )),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //GetData(collection: "Area", isSearch: true,type: 1,SearchKey1: widget.ro,SearchKey2: "name",),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Text(
                          data.name,
                          style: GoogleFonts.acme(
                              fontSize: 22,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          data.avgRatings.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 15),
                            child: RatingBar(
                              rating: data.avgRatings,
                              size: 22,
                            )),
                      ],
                    ),
                  ],
                ),

                Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        data.description,
                        style: GoogleFonts.merriweather(
                            fontSize: 13,
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    )),

                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImageList(
                                        imageList: data.imagesT, index: 0))),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.30,
                              height: MediaQuery.of(context).size.width * 0.3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  data.imagesT[0].imageT,
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
                                        AppStrings.loading2Gif,
                                        fit: BoxFit.cover,
                                      );
                                    }
                                    return child;
                                  },
                                ),
                              ),
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImageList(
                                        imageList: data.imagesT, index: 1))),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.30,
                              height: MediaQuery.of(context).size.width * 0.3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  data.imagesT[1].imageT,
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
                                        AppStrings.loading2Gif,
                                        fit: BoxFit.cover,
                                      );
                                    }
                                    return child;
                                  },
                                ),
                              ),
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImageList(
                                        imageList: data.imagesT, index: 2))),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Opacity(
                                  opacity: 0.6,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    height:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        data.imagesT[2].imageT,
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
                                              AppStrings.loading2Gif,
                                              fit: BoxFit.cover,
                                            );
                                          }
                                          return child;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "+${data.imagesT.length - 2}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                  child: SizedBox(
                    height: 55,
                    width: 260,
                    child: TextButton(
                      onPressed: () async {
                        print(data.coordinatesY);
                        print(data
                            .coordinatesX); //29.405833973995296, 30.4192274478539

                        // final url =
                        //     "https://www.google.com/maps/search/?api=1&query=${29.405833973995296},${30.4192274478539}";
                        // if (await canLaunch(url)) {
                        //   await launch(url);
                        // } else {
                        //   throw 'Could not launch $url';
                        // }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 10),
                      child: Text(
                        index == 0 ? "Go to it!" : "Reserve!",
                        style: GoogleFonts.rye(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),

                // Align(
                //     alignment: Alignment.centerLeft,
                //     child: Container(
                //       margin: const EdgeInsets.all(20),
                //       child: Text(
                //         "The Near Hotels: ",
                //         style: GoogleFonts.acme(
                //             fontSize: 22,
                //             fontWeight: FontWeight.bold,
                //             color: Theme.of(context).colorScheme.primary),
                //       ),
                //     )),

                // // HOTELS(area_name: snapshot.data?.docs[0]["name"]),

                // const SizedBox(
                //   height: 15,
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}