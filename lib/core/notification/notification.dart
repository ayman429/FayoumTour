import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';

class FirebaseNotification {
  // Future<void> firebaseMessageBackgroundHandler(RemoteMessage message) async {
  //   // if (kDebugMode) {
  //   //   print(message.messageId);
  //   // }
  //   print(message.messageId);
  // }

  // final navigatorKey = GlobalKey<NavigatorState>();
  // FlutterLocalNotificationsPlugin _localNotifications =
  //   FlutterLocalNotificationsPlugin();

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'high importance Notifications',
    description: 'This channel is used for importan notifications',
    importance: Importance.defaultImportance,
  );
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    // print("---------------------------------------------------------------");
    // print("ccccccccc ${message.notification!.title}");
    if (message.notification!.title == "FayTour Community") {
      navigatorKey.currentState?.pushNamed(
        '/post',
        // arguments: message,
      );
    }
    // navigatorKey.currentState?.pushNamed(
    //   '/post',
    //   // arguments: message,
    // );
  }

  void notification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    // FlutterLocalNotificationsPlugin _localNotifications =
    //   FlutterLocalNotificationsPlugin();
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User permission");
    } else {
      print("no no n on o n");
    }
    // FirebaseMessaging.instance.
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      _localNotifications.show(
        notification.hashCode,
        notification!.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );

      print(
          "Title: ${message.notification?.title} Body: ${message.notification?.body}");
    });
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   print("App opened from background notification:");
    //   print(
    //       "Title: ${message.notification?.title} Body: ${message.notification?.body}");
    // });
  }

  Future initLocalNotifications() async {
    // const ios = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode("${payload.payload}"));
      handleMessage(message);
    });
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }
}
