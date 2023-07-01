import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fayoumtour/core/utils/constance/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Authentication/data/models/user_details_model.dart';
import '../error/exceptions.dart';
import '../network/api_constance.dart';
import '../network/dio_factory.dart';
import '../network/error_message_model.dart';

abstract class BaseFavourits {
  Future<Unit> saveFavourits(data, String type);
  Future<List<Map<String, dynamic>>> getFavourits();
  Future<bool> searchFavourit(data);
  Future<void> deleteFavourit(String name);
}

class FavouritStorage extends BaseFavourits {
  // var userId = "";
  Future<UserDetailsModel> getUsersDetails() async {
    try {
      Dio dio = (await DioFactory.create()).dio;
      // Get user info , Request and Response
      final response = await dio.get(ApiConstance.userDetailsPath);
      // return user info
      return UserDetailsModel.fromJson(response.data);
    } on DioError catch (e) {
      // return Error Message
      throw ServerException(
        errorMassageModel: ErrorMassageModel.fromJson(e.response),
      );
    }
  }

  @override
  Future<Unit> saveFavourits(data, type) async {
    // print(data);
    // final token = await getIt<AccessToken>().getToken();
    var user = await getUsersDetails();
    // userId = user.id;
    sharedPreferences!.setString("USERID", user.id ?? "0");

    final prefs = await SharedPreferences.getInstance();
    List<dynamic> favList = [];
    favList.addAll(await getFavourits());
    Map<String, dynamic> map;
    map = {
      "id": data.id.toString(),
      "type": type,
      "name": data.name,
      "image": data.originalImage,
    };
    favList.add(map);
    // print(favList);
    await prefs.setString("${user.id}", json.encode(favList));
    return Future.value(unit);
  }

  @override
  Future<List<Map<String, dynamic>>> getFavourits() async {
    // final token = await getIt<AccessToken>().getToken();
    // print("--------------------------------");
    var userId = sharedPreferences!.getString("USERID") ?? "";
    // print(userId);
    if (userId != "") {
      final prefs = await SharedPreferences.getInstance();
      String jsonString = prefs.getString(userId) ?? "";
      if (jsonString != "") {
        List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((e) => Map<String, dynamic>.from(e)).toList();
      }
    }
    return [];
  }

  @override
  Future<bool> searchFavourit(data) async {
    final searchList = await getFavourits();
    // print("======================");
    // print(searchList);
    bool flag = false;
    for (var element in searchList) {
      if (element.containsValue(data.id.toString())) {
        flag = true;
        // print("--=__=--> $flag");
        break;
      } else {
        flag = false;
        // print("--=__=--> $flag");
      }
    }
    return flag;
  }

  @override
  Future<void> deleteFavourit(name) async {
    // final token = await getIt<AccessToken>().getToken();
    var userId = sharedPreferences!.getString("USERID") ?? "";
    final prefs = await SharedPreferences.getInstance();
    final updatedList = await getFavourits();
    updatedList.removeWhere((element) => element['name'] == name);
    await prefs.setString(userId, json.encode(updatedList));
  }
}
