import 'package:dio/dio.dart';

class AddNotification {
  void addNotification({topics, body, title}) async {
    Dio dio = Dio();
    dio.options = BaseOptions(
      headers: {
        'Authorization':
            'key=AAAAdbA1nO4:APA91bEIEO0VE5xXdAcm09ezdCzZiAft_0Pr9VyiLYdf8_uGD1q1GZ-OaAiOTQ_bHIbsK0kmwYSAoniYa8eVGoZRlNWedymsJXli_j1c3XGLOIzldj7JMWc47rrR1yOi7761DwJO_hKL',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );
    try {
      final response =
          await dio.post("https://fcm.googleapis.com/fcm/send", data: {
        "to": topics,
        "priority": "high",
        "notification": {
          "body": body,
          "title": title,
          // "image": userImage
        }
      });
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
