//This file is for the upbar of the hotels pages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';
import 'check_favorite.dart';
import 'home_details_of_tourism_hotel.dart';

class UpBarImage extends StatelessWidget {
  // String img;
  int index;
  var data;
  String type;
  UpBarImage({
    Key? key,
    required this.index,
    required this.data,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height / 3),
          child: Stack(
            children: [
              CachedNetworkImage(imageUrl: data.originalImage,
                height: MediaQuery.of(context).size.height / 2.9,
                width: MediaQuery.of(context).size.width,
                fadeInDuration: const Duration(milliseconds: 350),
                  fadeOutDuration: const Duration(milliseconds: 350),
                fit: BoxFit.cover,
                // placeholder: (context, url) {
                //     return Image.asset(AppStrings.loading2Gif,fit: BoxFit.cover,);
                //   },
                  errorWidget: (context, url, error) {
                    return Image.asset(AppStrings.error1Gif,fit: BoxFit.cover,);
                  },
                ),
                // Image.network(
                //   data.originalImage,
                //   fit: BoxFit.cover,
                //   errorBuilder: (context, error, stackTrace) {
                //     return Image.asset(
                //       AppStrings.error1Gif,
                //       fit: BoxFit.cover,
                //     );
                //   },
                //   loadingBuilder: (context, child, loadingProgress) {
                //     if (loadingProgress != null) {
                //       return Image.asset(
                //         AppStrings.loading2Gif,
                //         fit: BoxFit.cover,
                //       );
                //     }
                //     return child;
                //   },
                // ),
              
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Container(
                  margin: EdgeInsets.fromLTRB(
                      sharedPreferences!.getString("Language") == "AR" ? 0 : 8,
                      7,
                      sharedPreferences!.getString("Language") == "AR" ? 8 : 0,
                      0),
                  child: FloatingActionButton(
                    elevation: 0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(
                      Icons.arrow_back_rounded,
                    ),
                  ),
                ),
                actions: [
                  CheckFavorite(
                    data: data,
                    type: type,
                  )
                  // if (index == 0)
                  //   CheckFavorite(
                  //     id: data.id,
                  //     // fav_value: favPlaceMap[data.id],
                  //     fav_value: data.fav_value,
                  //     index: index,
                  //   )
                  // else
                  //   CheckFavorite(
                  //     id: data.id,
                  //     // fav_value: favHotelMap[data.id],
                  //     fav_value: data.fav_value,
                  //     index: index,
                  //   )
                ],
              ),
            ],
          )),
      bottomNavigationBar: Details(data: data, index: index),
    );
  }
}
