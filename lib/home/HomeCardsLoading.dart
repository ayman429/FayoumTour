
// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../core/utils/constance/shared_pref.dart';
import 'RatingStarsBar.dart';


class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
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
                        child: Image.asset(
                          "assets/images/holder.png",
                          fit: BoxFit.cover,
                          )
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
                      padding: sharedPreferences!.getString("Language") == "AR"
                                ? const EdgeInsets.only(bottom: 8,left: 45)
                                : const EdgeInsets.only(bottom: 5.5,right: 45),
                      child: Container(
                        height: (12/772)*MediaQuery.of(context).size.height,//12,
                        //width: 15,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                        padding:
                            sharedPreferences!.getString("Language") == "AR"
                                ? const EdgeInsets.only(bottom: 5)
                                : const EdgeInsets.only(bottom: 2),
                        child:
                            RatingBar(rating: 0.0, ratingCount: 0),
                      ),
                  ],
              ),
            )
                      ],
                    ),
                  );
                },
              )
    );
  }
}