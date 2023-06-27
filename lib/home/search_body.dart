import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fayoumtour/core/utils/constance/strings_manager.dart';

import '../TourismPlaces/presentation/screens/places_details.dart';
import '../hotels/presentation/screens/hotels_details.dart';

class SeachBody extends StatelessWidget {
  var data;
  String type;
  SeachBody({
    Key? key,
    required this.data,
    required this.type,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (type == "places") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PlacesDetails(tourId: data.id.toString())));
        } else if (type == "hotels") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HotelsDetails(hotelsId: data.id.toString())));
        } else {
          print("error");
        }
      },
      child: Container(
        height: 200,
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(7),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6,
            ),
          ],
          // image: DecorationImage(image: Image.network("src")),
        ),
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
                  stops: [0, 0.0, 0.8, 1],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.network(
                  data.originalImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(AppStrings.error1Gif);
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return Image.asset(AppStrings.loading2Gif);
                    }
                    return child;
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.name,
                  style: GoogleFonts.merriweather(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),
          ],
        ),
      ),
    );
    
  }
}