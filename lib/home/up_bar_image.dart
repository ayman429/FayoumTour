//This file is for the upbar of the hotels pages
import 'package:flutter/material.dart';

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
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  data.originalImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppStrings.error1Gif,
                      fit: BoxFit.cover,
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
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
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Container(
                  margin: const EdgeInsets.fromLTRB(7, 7, 0, 0),
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
                  CheckFavorite(data: data, type: type),
                ],
              ),
            ],
          )),
      bottomNavigationBar: Details(data: data, index: index),
    );
  }
}
