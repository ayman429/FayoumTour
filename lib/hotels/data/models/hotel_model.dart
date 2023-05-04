import '../../../hotels/data/models/img_model.dart';

import '../../domain/entities/hotel.dart';
import 'created_by_model.dart';
import 'rate_on_by_one_model.dart';

class HotelModel extends Hotel {
  HotelModel(
      {required super.id,
      required super.name,
      required super.description,
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
      required super.images2,
      required super.originalImage,
      required super.user,
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
      avgRatings: json['avg_ratings'],
      rateOneByOne: RateOneByOneModel.fromJson(json['rate_one_by_one']),

      images2: image,

      //   if (json['images'] != null) {
      //   json['images'].forEach((v) {
      //     images.add(new Images.fromJson(v));
      //   });
      // }

      originalImage: json['originalImage'],
      user: json['user'],
      createdBy: CreatedByModel.fromJson(json['created_by']),
    );
  }

  HotelModel.castFromEntity(final Hotel hotel)
      : super(
            id: hotel.id,
            email: hotel.email,
            name: hotel.name,
            Double: hotel.Double,
            address: hotel.address,
            avgRatings: hotel.avgRatings,
            chalet: hotel.chalet,
            city: hotel.city,
            description: hotel.description,
            images2: hotel.images2,
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
            createdBy: hotel.createdBy);
}
