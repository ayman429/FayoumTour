import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/api_constance.dart';

abstract class BaseAccessToken {
  Future<Unit> saveToken(userToken);
  Future<String> getToken();
}

class AccessToken extends BaseAccessToken {
  @override
  Future<Unit> saveToken(userToken) async {
    // print(UserToken);
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value
    await prefs.setString(ApiConstance.KeyAccessToken, userToken);
    return Future.value(unit);
  }

  @override
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    // Try reading data from the counter key. If it doesn't exist, return 0.
    final key = prefs.get('KeyAccessToken') ?? 0;
    //print("KeyAccessToken: $key");
    return key.toString();
  }
}
