import 'package:dio/dio.dart';

import '../services/services_locator.dart';
import 'access_token_shared_preferences.dart';

class DioFactory {
  Dio dio;

  DioFactory(this.dio);

  static Future<DioFactory> create() async {
    final token = await getIt<AccessToken>().getToken();
    final dio = Dio();
    dio.options = BaseOptions(
      headers: {
        'Authorization': 'Token $token',
      },
    );
    return DioFactory(dio);
  }
}
