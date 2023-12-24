import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:umlcc_eval/main.dart';

import '../configs/constants.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  if (kDebugMode) {
    print("message title: ${message.notification!.title}");
    print("message body: ${message.notification!.body}");
    print("message payload: ${message.data}");
  }
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();

    if (!InnerStorage.hasData(kFCMToken) ||
        InnerStorage.read(kFCMToken) != fcmToken) {
      InnerStorage.write(kFCMToken, fcmToken);
    }

    //FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
