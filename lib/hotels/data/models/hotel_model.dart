// ignore_for_file: non_constant_identifier_names

import '../../../hotels/data/models/img_model.dart';

import '../../domain/entities/hotel.dart';
import 'created_by_model.dart';
import 'rate_on_by_one_model.dart';

class HotelModel extends Hotel {
  const HotelModel(
      {required super.id,
      required super.name,
      required super.nameAR,
      required super.description,
      required super.descriptionAR,
      required super.coordinatesX,
      required super.coordinatesY,
      required super.address,
      required super.city,
      required super.phone,
      required super.web,
      required super.email,
      required super.single,
      // ignore: avoid_types_as_parameter_names
      required super.Double,
      required super.triple,
      required super.sweet,
      required super.chalet,
      required super.villa,
      required super.totalRooms,
      required super.totalBeds,
      required super.noOfRatings,
      required super.avgRatings,
      required super.rateOneByOne,
      // required super.images,
      required super.imagesT,
      required super.originalImage,
      required super.user,
      required super.rate_value,
      required super.fav_value,
      required super.createdBy});

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    // List<ImagesModel> images = <ImagesModel>[];
    // ignore: deprecated_member_use
    List<Images2Model> image = <Images2Model>[];
    json['images'] != null
        ? json['images'].forEach((v) {
            // print("ob = ${json['images'][0]}");
            // print("vvvvvvvvvvvvvvvvvvvvvvvvvv= ${v}");
            image.add(Images2Model.fromJson(v));
          })
        : [];

    return HotelModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      nameAR: json['nameAR'],
      descriptionAR: json['descriptionAR'],
      coordinatesX: json['coordinatesX'],
      coordinatesY: json['coordinatesY'],
      address: json['address'],
      city: json['City'],
      phone: json['Phone'],
      web: json['web'],
      email: json['email'],
      single: json['Single'],
      Double: json['Double'],
      triple: json['Triple'],
      sweet: json['Sweet'],
      chalet: json['chalet'],
      villa: json['villa'],
      totalRooms: json['totalRooms'],
      totalBeds: json['TotalBeds'],
      noOfRatings: json['no_of_ratings'],
      avgRatings: double.parse(
          (json['avg_ratings']).toStringAsFixed(1)), //json['avg_ratings'],
      rateOneByOne: RateOneByOneModel.fromJson(json['rate_one_by_one']),

      imagesT: image,

      //   if (json['images'] != null) {
      //   json['images'].forEach((v) {
      //     images.add(new Images.fromJson(v));
      //   });
      // }

      originalImage: json['originalImage'],
      user: json['user'],
      rate_value: json['rate_value'],
      fav_value: json['fav_value'],
      createdBy: CreatedByModel.fromJson(json['created_by']),
    );
  }

  HotelModel.castFromEntity(final Hotel hotel)
      : super(
            id: hotel.id,
            email: hotel.email,
            name: hotel.name,
            nameAR: hotel.nameAR,
            Double: hotel.Double,
            address: hotel.address,
            avgRatings: hotel.avgRatings,
            chalet: hotel.chalet,
            city: hotel.city,
            description: hotel.description,
            descriptionAR: hotel.descriptionAR,
            coordinatesX: hotel.coordinatesX,
            coordinatesY: hotel.coordinatesY,
            imagesT: hotel.imagesT,
            noOfRatings: hotel.noOfRatings,
            originalImage: hotel.originalImage,
            phone: hotel.phone,
            rateOneByOne: hotel.rateOneByOne,
            single: hotel.single,
            sweet: hotel.single,
            totalBeds: hotel.totalBeds,
            totalRooms: hotel.totalRooms,
            triple: hotel.triple,
            user: hotel.user,
            villa: hotel.villa,
            web: hotel.web,
            rate_value: hotel.rate_value,
            fav_value: hotel.fav_value,
            createdBy: hotel.createdBy);
}
