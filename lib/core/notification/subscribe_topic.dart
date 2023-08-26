import 'package:firebase_messaging/firebase_messaging.dart';

import '../utils/constance/shared_pref.dart';

void unsubscribeENTopic() async {
  var user = sharedPreferences!.getString("USERID") ?? "";
  print("//////////un////////////////");
  print(user);

  try {
    await FirebaseMessaging.instance.unsubscribeFromTopic("POST_EN");
    await FirebaseMessaging.instance.unsubscribeFromTopic("ALL_EN");
    await FirebaseMessaging.instance.unsubscribeFromTopic("COMMENT_EN$user");
    await FirebaseMessaging.instance.unsubscribeFromTopic("LIKE_EN$user");
    await FirebaseMessaging.instance
        .unsubscribeFromTopic("ReserveState_EN$user");
  } catch (e) {
    print("$e ------------------->");
  }
}

void subscribeARTopic() async {
  var user = sharedPreferences!.getString("USERID") ?? "";

  unsubscribeENTopic();
  await FirebaseMessaging.instance.subscribeToTopic("POST_AR");
  await FirebaseMessaging.instance.subscribeToTopic("ALL_AR");
  await FirebaseMessaging.instance.subscribeToTopic("COMMENT_AR$user");
  await FirebaseMessaging.instance.subscribeToTopic("LIKE_AR$user");
  await FirebaseMessaging.instance.subscribeToTopic("ReserveState_AR$user");
}

void unsubscribeARTopic() async {
  var user = sharedPreferences!.getString("USERID") ?? "";

  try {
    await FirebaseMessaging.instance.unsubscribeFromTopic("POST_AR");
    await FirebaseMessaging.instance.unsubscribeFromTopic("ALL_AR");
    await FirebaseMessaging.instance.unsubscribeFromTopic("COMMENT_AR$user");
    await FirebaseMessaging.instance.unsubscribeFromTopic("LIKE_AR$user");
    await FirebaseMessaging.instance
        .unsubscribeFromTopic("ReserveState_AR$user");
  } catch (e) {
    print("$e ------------------->");
  }
}

void subscribeENTopic() async {
  var user = sharedPreferences!.getString("USERID") ?? "";
  print("//////////su///////////////////");
  print(user);
  unsubscribeARTopic();

  await FirebaseMessaging.instance.subscribeToTopic("POST_EN");
  await FirebaseMessaging.instance.subscribeToTopic("ALL_EN");
  await FirebaseMessaging.instance.subscribeToTopic("COMMENT_EN$user");
  await FirebaseMessaging.instance.subscribeToTopic("LIKE_EN$user");
  await FirebaseMessaging.instance.subscribeToTopic("ReserveState_EN$user");
}
