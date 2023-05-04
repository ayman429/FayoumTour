import 'package:equatable/equatable.dart';

import 'created_by.dart';
import 'img.dart';
import 'rate_one_by_one.dart';

class TourismPlace extends Equatable {
  int id;
  String name;
  String type;
  String address;
  String description;
  double coordinatesX;
  double coordinatesY;
  String originalImage;
  List<ImagesT> imagesT;
  int noOfRatings;
  double avgRatings;
  RateOneByOne rateOneByOne;
  int user;
  CreatedBy? createdBy;
  TourismPlace({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.description,
    required this.coordinatesX,
    required this.coordinatesY,
    required this.originalImage,
    required this.imagesT,
    required this.noOfRatings,
    required this.avgRatings,
    required this.rateOneByOne,
    required this.user,
    this.createdBy,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['address'] = address;
    data['description'] = description;
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
      type,
      address,
      description,
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
