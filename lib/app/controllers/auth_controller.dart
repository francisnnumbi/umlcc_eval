import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umlcc_eval/api/api.dart';
import 'package:umlcc_eval/main.dart';

import '../models/user.dart';
import '../ui/auth/verify/verify_page.dart';

class AuthController extends GetxController {
  // ------- static methods ------- //
  static AuthController get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<AuthController>(() async => AuthController());
  }

// ------- ./static methods ------- //

  final Rxn<User> user = Rxn<User>();

  final cookies = <Cookie>[].obs;
  final otp = ''.obs;
  final x_did = ''.obs;

  bool get isLogged => false;

  register(Map<String, dynamic> datum) async {
    datum['type'] = 'individual';
    ApiProvider.api.register(datum).then((response) {
      if (kDebugMode) {
        printInfo(info: response.headers.toString());

        final List<String>? kks = response.headers[HttpHeaders.setCookieHeader];
        cookies.clear();
        for (var element in kks!) {
          var c = Cookie.fromSetCookieValue(element);
          cookies.add(c);
          //    printInfo(info: "cookie :: ${c.name}");
        }
      }
      if (response.statusCode == 201) {
        final data = response.data;
        otp.value = data['otp'].toString();
        user.value = User.fromJson(datum);

        printInfo(info: data.toString());

        Get.snackbar(
          "Registration successful",
          data['message'] +
              ". Please verify your account to continue. CODE: " +
              data['otp'].toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade400,
          colorText: Colors.white,
          duration: null,
          // const Duration(seconds: 5),
          isDismissible: true,
          mainButton: TextButton(
            onPressed: () {
              Get.back();
              Get.offNamed(VerifyPage.route);
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        // Get.offNamed(VerifyPage.route);
      }
    }).onError((error, stackTrace) {
      printError(info: error.toString());
    });
  }

  verify(Map<String, dynamic> data) async {
    data['fcm_token'] =
        'ensurance_session=${cookies.where((element) => element.name == 'ensurance_session').first.value}';

    if (kDebugMode) {
      printInfo(info: data.toString());
    }

    ApiProvider.api
        .verify(
      data,
      xDid: x_did.value,
      identity: user.value!.identity,
    )
        .then((response) {
      if (response.statusCode == 200) {
        final data = response.data;
        //  user.value = User.fromJson(data['user']);
        Get.snackbar(
          "Verification successful",
          data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade400,
          colorText: Colors.white,
          isDismissible: true,
          mainButton: TextButton(
            onPressed: () {
              Get.back();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        // Get.offNamed(VerifyPage.route);
      }
    }).onError((error, stackTrace) {
      printError(info: stackTrace.toString());
    });
  }

  login(Map<String, dynamic> datum) async {
    /* if (kDebugMode) {
      printInfo(info: datum.toString());
    }*/

    ApiProvider.api
        .login(
      datum,
      xDid: x_did.value,
      identity: user.value!.identity,
    )
        .then((response) {
      if (response.statusCode == 200) {
        final data = response.data;
        if (kDebugMode) {
          printInfo(info: data.toString());
        }
        // otp.value = data['otp'].toString();
        // user.value = User.fromJson(data['user']);
        Get.snackbar(
          "Login successful",
          data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade400,
          colorText: Colors.white,
          isDismissible: true,
          mainButton: TextButton(
            onPressed: () {
              Get.back();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        // Get.offNamed(VerifyPage.route);
      }
    }).onError((error, stackTrace) {
      printError(info: error.toString());
    });
  }

  retrieveDeviceInfo() async {
    final devInfo = await deviceInfoPlugin.deviceInfo;
    x_did.value = devInfo.data['id'].toString();
    if (kDebugMode) {
      printInfo(info: devInfo.data.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    retrieveDeviceInfo();
  }
}
