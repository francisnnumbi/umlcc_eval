import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:umlcc_eval/api/api.dart';

import '../models/user.dart';

class AuthController extends GetxController {
  // ------- static methods ------- //
  static AuthController get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<AuthController>(() async => AuthController());
  }

// ------- ./static methods ------- //

  final Rxn<User> user = Rxn<User>();

  bool get isLogged => false;

  register(Map<String, dynamic> data) async {
    data['type'] = 'individual';
    ApiProvider.api.register(data).then((response) {
      if (kDebugMode) {
        final List<String>? kks = response.headers[HttpHeaders.setCookieHeader];
        for (var element in kks!) {
          var c = Cookie.fromSetCookieValue(element);
          printInfo(info: "HIHIH6 : ${c.name}");
        }
      }
    }).onError((error, stackTrace) {
      printError(info: error.toString());
    });
  }

  login(Map<String, dynamic> data) async {}

  verify(Map<String, dynamic> data) async {}
}
