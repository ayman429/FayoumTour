import 'package:flutter/material.dart';

import '../core/utils/constance/shared_pref.dart';


class RatingBar extends StatelessWidget {
  final double rating;
  final double size;
  final int ratingCount;
  const RatingBar(
      {Key? key, required this.rating, this.ratingCount = 0, this.size = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> starList = [];

    int realNumber = rating.floor();
    int partNumber = ((rating - realNumber) * 10).ceil();

    for (int i = 0; i < 5; i++) {
      if (i < realNumber) {
        starList.add(Icon(Icons.star, color: Colors.amber, size: size));
      } else if (i == realNumber) {
        starList.add(SizedBox(
          height: size,
          width: size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Icon(Icons.star, color: Colors.amber, size: size),
              ClipRect(
                clipper: _Clipper(part: partNumber),
                child: Icon(Icons.star, color: Colors.grey, size: size),
              )
            ],
          ),
        ));
      } else {
        starList.add(Icon(Icons.star, color: Colors.grey, size: size));
      }
    }
    ratingCount != 0
        ? starList.add(
            Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('($ratingCount)',
                    style: TextStyle(
                        fontSize: size * 0.8,
                        color: Theme.of(context).colorScheme.onPrimary))),
          )
        : Container();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: starList,
    );
  }
}

class _Clipper extends CustomClipper<Rect> {
  final int part;

  _Clipper({required this.part});

  @override
  Rect getClip(Size size) {
    if(sharedPreferences!.getString("Language") == "AR")
    {
      return  Rect.fromLTRB(
    0.0,
    0.0,
    size.width - ((size.width / 10) * part),
    size.height,
  );
    }
    else
    {
      return Rect.fromLTRB(
      (size.width / 10) * part,
      0.0,
      size.width,
      size.height,
      );
    }
    
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}
