import '../../domain/entities/tourism_place.dart';
import 'created_by_model.dart';
import 'img_model.dart';
import 'rate_on_by_one_model.dart';

class TourismPlaceModel extends TourismPlace {
  TourismPlaceModel(
      {required super.id,
      required super.name,
      required super.type,
      required super.address,
      required super.description,
      required super.coordinatesX,
      required super.coordinatesY,
      required super.originalImage,
      required super.images2,
      required super.noOfRatings,
      required super.avgRatings,
      required super.rateOneByOne,
      required super.user,
      required super.createdBy});

  factory TourismPlaceModel.fromJson(Map<String, dynamic> json) {
    List<Images2Model> image = <Images2Model>[];
    json['images'] != null
        ? json['images'].forEach((v) {
            image.add(Images2Model.fromJson(v));
          })
        : [];
    return TourismPlaceModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      address: json['address'],
      description: json['description'],
      coordinatesX: json['coordinatesX'],
      coordinatesY: json['coordinatesY'],
      originalImage: json['originalImage'],
      images2: image,
      noOfRatings: json['no_of_ratings'],
      avgRatings: json['avg_ratings'],
      rateOneByOne: RateOneByOneModel.fromJson(json['rate_one_by_one']),
      user: json['user'],
      createdBy: CreatedByModel.fromJson(json['created_by']),
    );
  }
  TourismPlaceModel.castFromEntity(final TourismPlace tourismPlace)
      : super(
          id: tourismPlace.id,
          name: tourismPlace.name,
          type: tourismPlace.type,
          address: tourismPlace.address,
          description: tourismPlace.description,
          coordinatesX: tourismPlace.coordinatesX,
          coordinatesY: tourismPlace.coordinatesY,
          originalImage: tourismPlace.originalImage,
          avgRatings: tourismPlace.avgRatings,
          noOfRatings: tourismPlace.noOfRatings,
          rateOneByOne: tourismPlace.rateOneByOne,
          images2: tourismPlace.images2,
          user: tourismPlace.user,
          createdBy: tourismPlace.createdBy,
        );
}
