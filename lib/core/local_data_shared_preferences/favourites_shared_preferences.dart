import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/services_locator.dart';
import 'access_token_shared_preferences.dart';

abstract class BaseFavourits {
  Future<Unit> saveFavourits(data, String type);
  Future<List<Map<String, dynamic>>> getFavourits();
  Future<bool> searchFavourit(data);
  Future<void> deleteFavourit(String name);
}

class FavouritStorage extends BaseFavourits {
  @override
  Future<Unit> saveFavourits(data, type) async {
    print(data);
    final token = await getIt<AccessToken>().getToken();

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
    print(favList);
    await prefs.setString(token, json.encode(favList));
    return Future.value(unit);
  }

  @override
  Future<List<Map<String, dynamic>>> getFavourits() async {
    final token = await getIt<AccessToken>().getToken();

    final prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString(token) ?? "";
    if (jsonString != "") {
      List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((e) => Map<String, dynamic>.from(e)).toList();
    }

    return [];
  }

  @override
  Future<bool> searchFavourit(data) async {
    final token = await getIt<AccessToken>().getToken();
    final prefs = await SharedPreferences.getInstance();
    final searchList = await getFavourits();
    // print("=============================");
    // print(searchList);
    // Map<String, dynamic> map;
    // map = {
    //   "id": data.id.toString(),
    //   "type": type,
    //   "name": data.name,
    //   "image": data.originalImage,
    // };
    bool flag = false;
    // print("--===--> ${data.id}");
    for (var element in searchList) {
      if (element.containsValue(data.id.toString())) {
        flag = true;
        print("--=__=--> $flag");
        break;
      } else {
        flag = false;
        print("--=__=--> $flag");
      }
    }
    return flag;
  }

  @override
  Future<void> deleteFavourit(name) async {
    final token = await getIt<AccessToken>().getToken();
    final prefs = await SharedPreferences.getInstance();
    final updatedList = await getFavourits();
    updatedList.removeWhere((element) => element['name'] == name);
    await prefs.setString(token, json.encode(updatedList));
  }
}
