// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

import 'created_by.dart';
import 'img.dart';
import 'rate_one_by_one.dart';

class Hotel extends Equatable {
  final int id;
  final String name;
  final String nameAR;
  final String description;
  final String descriptionAR;
  final double coordinatesX;
  final double coordinatesY;
  final String address;
  final String city;
  final String phone;
  final String web;
  final String email;
  final int single;
  final int Double;
  final int triple;
  final int sweet;
  final int chalet;
  final int villa;
  final int totalRooms;
  final int totalBeds;
  final int noOfRatings;
  final double avgRatings;
  final RateOneByOne rateOneByOne;
  // List<Images> images;
  final List<Images2> imagesT;
  // String images;
  final String originalImage;
  final int user;
  final CreatedBy? createdBy;
  final int? rate_value;
  final int? fav_value;

  const Hotel(
      {required this.id,
      required this.name,
      required this.nameAR,
      required this.description,
      required this.descriptionAR,
      required this.coordinatesX,
      required this.coordinatesY,
      required this.address,
      required this.city,
      required this.phone,
      required this.web,
      required this.email,
      required this.single,
      required this.Double,
      required this.triple,
      required this.sweet,
      required this.chalet,
      required this.villa,
      required this.totalRooms,
      required this.totalBeds,
      required this.noOfRatings,
      required this.avgRatings,
      required this.rateOneByOne,
      // required this.images,
      required this.imagesT,
      required this.originalImage,
      required this.user,
      this.rate_value,
      this.fav_value,
      this.createdBy});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    // RateOneByOneModel rateOneByOne;
    // Map<String, dynamic> rate = rateOneByOne.toJson();
    data['id'] = id;
    data['name'] = name;
    data['nameAR'] = nameAR;
    data['description'] = description;
    data['descriptionAR'] = descriptionAR;
    data['coordinatesX'] = coordinatesX;
    data['coordinatesY'] = coordinatesY;
    data['address'] = address;
    data['City'] = city;
    data['Phone'] = phone;
    data['web'] = web;
    data['email'] = email;
    data['Single'] = single;
    data['Double'] = Double;
    data['Triple'] = triple;
    data['Sweet'] = sweet;
    data['chalet'] = chalet;
    data['villa'] = villa;
    // data['totalRooms'] = this.totalRooms;
    data['TotalBeds'] = totalBeds;
    data['no_of_ratings'] = noOfRatings;
    data['avg_ratings'] = avgRatings;
    data['rate_one_by_one'] = rateOneByOne.toJson();
    // data['images'] = this.images;
    data['images'] = imagesT.map((v) => v.toJson()).toList();
    // data['images'] = this.images.toJson();
    // data['images'] = this.images2.toJson();
    data['originalImage'] = originalImage;
    data['user'] = user;
    // data['created_by'] = this.createdBy;
    return data;
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      nameAR,
      description,
      descriptionAR,
      coordinatesX,
      coordinatesY,
      address,
      city,
      phone,
      web,
      email,
      single,
      Double,
      triple,
      sweet,
      chalet,
      villa,
      totalRooms,
      totalBeds,
      noOfRatings,
      avgRatings,
      rateOneByOne,
      imagesT,
      originalImage,
      user,
    ];
  }
}
