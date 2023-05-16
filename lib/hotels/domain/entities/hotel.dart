import 'package:equatable/equatable.dart';

import 'Images.dart';
import 'created_by.dart';
import 'img.dart';
import 'rate_one_by_one.dart';

class Hotel extends Equatable {
  int id;
  String name;
  String description;
  String address;
  String city;
  String phone;
  String web;
  String email;
  int single;
  int Double;
  int triple;
  int sweet;
  int chalet;
  int villa;
  int totalRooms;
  int totalBeds;
  int noOfRatings;
  double avgRatings;
  RateOneByOne rateOneByOne;
  // List<Images> images;
  List<Images2> imagesT;
  // String images;
  String originalImage;
  int user;
  CreatedBy? createdBy;

  Hotel(
      {required this.id,
      required this.name,
      required this.description,
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
      this.createdBy});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    // RateOneByOneModel rateOneByOne;
    // Map<String, dynamic> rate = rateOneByOne.toJson();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
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
      description,
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
