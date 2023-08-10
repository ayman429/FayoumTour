import 'package:fayoumtour/TourismPlaces/data/models/img_model.dart';

import '../../domain/entities/tourism_place.dart';
import 'rate_on_by_one_model.dart';

class TourismPlaceModel extends TourismPlace {
  TourismPlaceModel(
      {required super.id,
      required super.name,
      required super.nameAR,
      required super.type,
      required super.address,
      required super.description,
      required super.descriptionAR,
      required super.coordinatesX,
      required super.coordinatesY,
      required super.originalImage,
      required super.imagesT,
      required super.noOfRatings,
      required super.avgRatings,
      required super.rateOneByOne,
      required super.user,
      required super.rate_value,
      required super.fav_value
      // required super.createdBy
      });

  factory TourismPlaceModel.fromJson(Map<String, dynamic> json) {
    List<ImagesTModel> image = <ImagesTModel>[];
    json['images'] != null
        ? json['images'].forEach((v) {
            image.add(ImagesTModel.fromJson(v));
          })
        : [];
    return TourismPlaceModel(
      id: json['id'],
      name: json['name'],
      nameAR: json['nameAR'],
      type: json['type'],
      address: json['address'],
      description: json['description'],
      descriptionAR: json['descriptionAR'],
      coordinatesX: json['coordinatesX'],
      coordinatesY: json['coordinatesY'],
      originalImage: json['originalImage'],
      imagesT: image,
      noOfRatings: json['no_of_ratings'],
      avgRatings: double.parse(
          (json['avg_ratings']).toStringAsFixed(1)), //json['avg_ratings'],
      rateOneByOne: RateOneByOneModel.fromJson(json['rate_one_by_one']),
      user: json['user'],
      // createdBy: CreatedByModel.fromJson(json['created_by']),
      rate_value: json['rate_value'],
      fav_value: json['fav_value'],
    );
  }
  TourismPlaceModel.castFromEntity(final TourismPlace tourismPlace)
      : super(
          id: tourismPlace.id,
          name: tourismPlace.name,
          nameAR: tourismPlace.nameAR,
          type: tourismPlace.type,
          address: tourismPlace.address,
          description: tourismPlace.description,
          descriptionAR: tourismPlace.descriptionAR,
          coordinatesX: tourismPlace.coordinatesX,
          coordinatesY: tourismPlace.coordinatesY,
          originalImage: tourismPlace.originalImage,
          avgRatings: tourismPlace.avgRatings,
          noOfRatings: tourismPlace.noOfRatings,
          rateOneByOne: tourismPlace.rateOneByOne,
          imagesT: tourismPlace.imagesT,
          user: tourismPlace.user,
          createdBy: tourismPlace.createdBy,
          rate_value: tourismPlace.rate_value,
          fav_value: tourismPlace.fav_value,
        );
}
