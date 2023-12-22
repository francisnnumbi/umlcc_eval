import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:umlcc_eval/main.dart';

import '../configs/constants.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    if (kDebugMode) {
      print("FCMToken: $fcmToken");
    }
    InnerStorage.write(kFCMToken, fcmToken);
  }
}
