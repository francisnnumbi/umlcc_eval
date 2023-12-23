import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umlcc_eval/api/api.dart';
import 'package:umlcc_eval/app/ui/auth/login/login_page.dart';
import 'package:umlcc_eval/app/ui/home/home_page.dart';
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

  //final x_did = ''.obs;
  final _loggedIn = false.obs;

  bool get isLogged => _loggedIn.value;

  String get otp => InnerStorage.read(kOtp).toString();

  register(Map<String, dynamic> datum) async {
    datum['type'] = 'individual';
    datum[kIdentity] = InnerStorage.read(kIdentity).toString();
    ApiProvider.api.register(datum).then((response) {
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
    datum[kIdentity] = InnerStorage.read(kIdentity).toString();
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
    datum['fcm_token'] = InnerStorage.read(kFCMToken).toString();

    ApiProvider.api.verify(datum).then((response) {
      if (response.statusCode == 200) {
        final data = response.data;
        InnerStorage.write(kAccessToken, data[kAccessToken]);
        InnerStorage.write(kTokenType, data[kTokenType]);

        InnerStorage.write(kIdentity, datum[kIdentity].toString());
        InnerStorage.write(kPhone, datum[kPhone].toString());

        _loggedIn.value = true;

        loadUserData();
        Get.snackbar(
          "Verification successful",
          data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade400,
          colorText: Colors.white,
        );
        Get.offNamed(HomePage.route);
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

  silentLogin() {
    final identity = InnerStorage.read(kIdentity).toString();
    final phone = InnerStorage.read(kPhone).toString();
    final dialCode = InnerStorage.read(kDialCode).toString();

    if (identity.isEmpty || phone.isEmpty || dialCode.isEmpty) {
      return;
    }

    login({
      kIdentity: identity,
      kPhone: phone,
      kDialCode: dialCode,
    });
  }

  logout() {
    InnerStorage.erase();
    _loggedIn.value = false;
    Get.offAllNamed(LoginPage.route);
  }

  Future<void> loadUserData() async {
    ApiProvider.api.me().then((response) {
      try {
        user.value = User.fromJson(response.data['data']);
      } catch (_) {
        user.value = null;
      }
    }).onError((error, stackTrace) {});
  }

  @override
  void onInit() {
    super.onInit();
    silentLogin();
  }
}
