import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umlcc_eval/api/api.dart';
import 'package:umlcc_eval/main.dart';

import '../../configs/constants.dart';
import '../models/user.dart';

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
  final _loggedIn = false.obs;

  bool get isLogged => _loggedIn.value;

  String get otp => InnerStorage.read(kOtp).toString() ?? '';

  String get cookiesString => cookies.join(';');

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

        // user.value = User.fromJson(datum);

        printInfo(info: data.toString());

        verify({
          "phone": datum[kPhone].toString(),
          "identity": datum[kIdentity].toString(),
          "otp": data[kOtp].toString(),
        });
      }
    }).onError((error, stackTrace) {
      printError(info: error.toString());
    });
  }

  login(Map<String, dynamic> datum) async {
    ApiProvider.api.login(datum).then((response) async {
      if (response.statusCode == 200) {
        final data = response.data;
        InnerStorage.write(kOtp, data[kOtp]);

        await InnerStorage.write(kIdentity, datum[kIdentity].toString());
        await InnerStorage.write(kPhone, datum[kPhone].toString());
        await InnerStorage.write(kDialCode, datum[kDialCode].toString());

        verify({
          "phone": datum[kPhone].toString(),
          "identity": datum[kIdentity].toString(),
          "otp": data[kOtp].toString(),
        });
      }
    }).onError((error, stackTrace) {
      printError(info: error.toString());
    });
  }

  verify(Map<String, dynamic> datum) async {
    datum['fcm_token'] = InnerStorage.read(kFCMToken);

    if (kDebugMode) {
      printInfo(info: "VERIFICATION INITIATED :: $datum");
    }

    ApiProvider.api.verify(datum).then((response) {
      final List<String>? kks = response.headers[HttpHeaders.setCookieHeader];
      cookies.clear();
      for (var element in kks!) {
        var c = Cookie.fromSetCookieValue(element);
        cookies.add(c);
      }
      if (response.statusCode == 200) {
        final data = response.data;
        InnerStorage.write(kAccessToken, data[kAccessToken]);
        InnerStorage.write(kTokenType, data[kTokenType]);

        InnerStorage.write(kIdentity, datum[kIdentity].toString());
        InnerStorage.write(kPhone, datum[kPhone].toString());

        // _loggedIn.value = true;

        if (kDebugMode) printInfo(info: "VERIFICATION SUCCESS :: $data");
        loadUserData();
        Get.snackbar(
          "Verification successful",
          data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade400,
          colorText: Colors.white,
        );
        // Get.offNamed(VerifyPage.route);
      } else {
        _loggedIn.value = false;
        Get.snackbar(
          "Verification failed",
          response.data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white,
        );
      }
    }).onError((error, stackTrace) {
      _loggedIn.value = false;
      printError(info: error.toString());
    });
  }

  Future<void> loadUserData() async {
    ApiProvider.api.me(cookiesString).then((response) {
      if (kDebugMode) {
        // printInfo(info: "LOGIN RESPONSE :: ${response.requestOptions.headers}");
        printInfo(info: "LOAD USER DATA SUCCESS :: ${response.data}");
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        printError(info: "LOAD USER DATA EXCEPTION :: $error");
      }
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
