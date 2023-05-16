import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseFavourits {
  Future<Unit> saveFavourits(userId, favId);
  Future<List<String>> getFavourits(userId);
}

class FavouritStorage extends BaseFavourits {
  @override
  Future<Unit> saveFavourits(userId, favId) async {
    // print(UserToken);
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    List<String> favList = await getFavourits(userId);
    favList.add(favId);
    // set value
    await prefs.setStringList(userId, favList);
    return Future.value(unit);
  }

  @override
  Future<List<String>> getFavourits(userId) async {
    final prefs = await SharedPreferences.getInstance();
    // Try reading data from the counter key. If it doesn't exist, return 0.
    final favList = prefs.getStringList(userId) ?? [];
    print(userId + "=>" + favList.toString());
    return favList;
  }
}
