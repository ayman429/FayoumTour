import 'package:flutter/material.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/youtubeController.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../core/utils/constance/strings_manager.dart';
import 'RatingStarsBar.dart';
import 'up_bar_image.dart';

class HomeCard extends StatelessWidget {
  var data;
  int index;
  String type;
  HomeCard({
    Key? key,
    required this.data,
    required this.index,
    required this.type,
  }) : super(key: key);
  final controller = YoutubeControllerSingleton.youtubeController;
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 200,
      width: MediaQuery.of(context).size.width * 0.7,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6,
              //offset: Offset(4,4),
            ),
          ]),
      child: InkWell(
        onTap: () {
          controller.pause();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UpBarImage(
                        data: data,
                        index: index,
                        type: type,
                      )));
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                    Colors.black,
                    Colors.transparent,
                  ],
                  stops: [0, 0, 0.6, 1],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: CachedNetworkImage(
                    imageUrl: data.originalImage,
                    fadeInDuration: const Duration(milliseconds: 350),
                    fadeOutDuration: const Duration(milliseconds: 350),
                    fit: BoxFit.cover,
                    // placeholder: (context, url) {
                    //   return Image.asset(
                    //     AppStrings.loading2Gif,
                    //     fit: BoxFit.cover,
                    //   );
                    // },
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        AppStrings.error1Gif,
                        fit: BoxFit.cover,
                      );
                    },
                  )
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
                  ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        sharedPreferences!.getString("Language") == "AR"
                            ? data.nameAR
                            : data.name,
                        style: sharedPreferences!.getString("Language") == "AR"
                            ?  TextStyle(
                                fontFamily: "marhey",
                                fontSize: (15/360)*MediaQuery.of(context).size.width,//15,
                                fontWeight: FontWeight.bold)
                            :  TextStyle(
                                fontFamily: "alata", fontSize: (15/360)*MediaQuery.of(context).size.width,//15
                                ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            sharedPreferences!.getString("Language") == "AR"
                                ? const EdgeInsets.only()
                                : const EdgeInsets.only(bottom: 2),
                        child: Text(
                          data.avgRatings.toString(),
                          style:
                              sharedPreferences!.getString("Language") == "AR"
                                  ?  TextStyle(
                                      fontSize: (14/360)*MediaQuery.of(context).size.width,//14,
                                      fontFamily: "marhey",
                                      fontWeight: FontWeight.bold)
                                  :  TextStyle(
                                      fontSize: (14/360)*MediaQuery.of(context).size.width,//14,
                                      fontFamily: "alata",
                                    ),
                        ),
                      ),
                      Padding(
                        padding:
                            sharedPreferences!.getString("Language") == "AR"
                                ? const EdgeInsets.only(bottom: 5)
                                : const EdgeInsets.only(bottom: 2),
                        child:
                            RatingBar(rating: data.avgRatings, ratingCount: 0),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
