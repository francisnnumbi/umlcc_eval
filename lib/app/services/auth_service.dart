import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umlcc_eval/api/api.dart';
import 'package:umlcc_eval/main.dart';

import '../../configs/constants.dart';
import '../models/user.dart';
import '../ui/auth/verify/verify_page.dart';

class AuthService extends GetxService {
  // ------- static methods ------- //
  static AuthService get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<AuthService>(() async => AuthService());
  }

// ------- ./static methods ------- //

  final Rxn<User> user = Rxn<User>();

  final cookies = <Cookie>[].obs;

  //final x_did = ''.obs;

  bool get isLogged => false;

  String get otp => InnerStorage.read(kOtp).toString() ?? '';

  register(Map<String, dynamic> datum) async {
    datum['type'] = 'individual';
    ApiProvider.api.register(datum).then((response) {
      final List<String>? kks = response.headers[HttpHeaders.setCookieHeader];
      cookies.clear();
      for (var element in kks!) {
        var c = Cookie.fromSetCookieValue(element);
        cookies.add(c);
        //    printInfo(info: "cookie :: ${c.name}");
      }
      if (response.statusCode == 201) {
        final data = response.data;
        InnerStorage.write(kOtp, data[kOtp].toString());

        InnerStorage.write(kIdentity, datum[kIdentity].toString());
        InnerStorage.write(kPhone, datum[kPhone].toString());
        InnerStorage.write(kDialCode, datum[kDialCode].toString());

        user.value = User.fromJson(datum);

        printInfo(info: data.toString());

        Get.snackbar(
          "Registration successful",
          data['message'] +
              ". Please verify your account to continue. CODE: " +
              data[kOtp].toString(),
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

  verify(Map<String, dynamic> datum) async {
    datum['fcm_token'] = InnerStorage.read(kFCMToken);

    if (kDebugMode) {
      printInfo(info: datum.toString());
    }

    ApiProvider.api.verify(datum).then((response) {
      final List<String>? kks = response.headers[HttpHeaders.setCookieHeader];
      cookies.clear();
      for (var element in kks!) {
        var c = Cookie.fromSetCookieValue(element);
        cookies.add(c);
        //    printInfo(info: "cookie :: ${c.name}");
      }
      if (response.statusCode == 200) {
        final data = response.data;
        InnerStorage.write(kAccessToken, data[kAccessToken]);
        InnerStorage.write(kTokenType, data[kTokenType]);

        InnerStorage.write(kIdentity, datum[kIdentity].toString());
        InnerStorage.write(kPhone, datum[kPhone].toString());

        if (kDebugMode) printInfo(info: data.toString());
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
      printError(info: error.toString());
    });
  }

  login(Map<String, dynamic> datum) async {
    ApiProvider.api.login(datum).then((response) async {
      final List<String>? kks = response.headers[HttpHeaders.setCookieHeader];
      cookies.clear();
      for (var element in kks!) {
        var c = Cookie.fromSetCookieValue(element);
        cookies.add(c);
        //    printInfo(info: "cookie :: ${c.name}");
      }
      if (response.statusCode == 200) {
        final data = response.data;
        InnerStorage.write(kOtp, data[kOtp]);

        await InnerStorage.write(kIdentity, datum[kIdentity].toString());
        await InnerStorage.write(kPhone, datum[kPhone].toString());
        await InnerStorage.write(kDialCode, datum[kDialCode].toString());

        // DataController.to.loadProducts();
        loadUserData();

        Get.snackbar(
          "Login successful",
          data['message'] +
              ". Please verify your account to continue. CODE: " +
              data[kOtp].toString(),
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
      }
    }).onError((error, stackTrace) {
      printError(info: error.toString());
    });
  }

  Future<void> loadUserData() async {
    if (kDebugMode) {
      printInfo(
          info: "LOAD USER DATA IDENTITY :: ${InnerStorage.read(kIdentity)}");
    }
    ApiProvider.api.me().then((value) {
      if (kDebugMode) printInfo(info: value.toString());
    }).onError((error, stackTrace) {
      printError(info: "LOAD USER DATA :: $error");
    });
  }

  retrieveDeviceInfo() async {
    /*  if (Platform.isAndroid) {
      final dInfo = await deviceInfoPlugin.androidInfo;
      String di = dInfo.data['fingerprint'].toString();
      if (kDebugMode) printInfo(info: di);
    } else if (Platform.isIOS) {
      final dInfo = await deviceInfoPlugin.iosInfo;
      String di = dInfo.data.toString();
    }*/
    final devInfo = await deviceInfoPlugin.deviceInfo;
    InnerStorage.write(kXDid, devInfo.data['id'].toString());
  }

  @override
  void onInit() {
    super.onInit();
    retrieveDeviceInfo();
  }
}
