import 'package:dio/dio.dart';

import '../services/services_locator.dart';
import '../local_data_shared_preferences/access_token_shared_preferences.dart';

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
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );
    return DioFactory(dio);
  }
}
