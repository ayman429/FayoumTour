// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

import 'created_by.dart';
import 'img.dart';
import 'rate_one_by_one.dart';

class TourismPlace extends Equatable {
  final int id;
  final String name;
  final String nameAR;
  final String type;
  final String address;
  final String description;
  final String descriptionAR;
  final double coordinatesX;
  final double coordinatesY;
  final String originalImage;
  final List<ImagesT> imagesT;
  final int noOfRatings;
  final double avgRatings;
  final RateOneByOne rateOneByOne;
  final int user;
  final CreatedBy? createdBy;
  final int? rate_value;
  final int? fav_value;
  const TourismPlace(
      {required this.id,
      required this.name,
      required this.nameAR,
      required this.type,
      required this.address,
      required this.description,
      required this.descriptionAR,
      required this.coordinatesX,
      required this.coordinatesY,
      required this.originalImage,
      required this.imagesT,
      required this.noOfRatings,
      required this.avgRatings,
      required this.rateOneByOne,
      required this.user,
      this.createdBy,
      this.rate_value,
      this.fav_value});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['nameAR'] = nameAR;
    data['type'] = type;
    data['address'] = address;
    data['description'] = description;
    data['descriptionAR'] = descriptionAR;
    data['coordinatesX'] = coordinatesX;
    data['coordinatesY'] = coordinatesY;
    data['originalImage'] = originalImage;
    data['images'] = imagesT.map((v) => v.toJson()).toList();
    data['no_of_ratings'] = noOfRatings;
    data['avg_ratings'] = avgRatings;
    data['rate_one_by_one'] = rateOneByOne.toJson();
    data['user'] = user;
    // data['created_by'] = createdBy;
    return data;
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      nameAR,
      type,
      address,
      description,
      descriptionAR,
      coordinatesX,
      coordinatesY,
      originalImage,
      imagesT,
      noOfRatings,
      avgRatings,
      rateOneByOne,
      user,
    ];
  }
}
