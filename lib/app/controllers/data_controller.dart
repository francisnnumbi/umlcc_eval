import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:umlcc_eval/app/services/auth_service.dart';

import '../../api/api.dart';

class DataController extends GetxController {
  // ------- static methods ------- //
  static DataController get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<DataController>(() async => DataController());
  }

// ------- ./static methods ------- //

  Future<void> loadProducts() async {
    ApiProvider.api.products(AuthService.to.cookiesString).then((response) {
      if (kDebugMode) printInfo(info: response.toString());
      if (response.statusCode == 200) {
        final data = response.data;
        printInfo(info: data.toString());
      }
    }).onError((error, stackTrace) {
      printError(info: "LOAD PRODUCTS :: $error");
    });
  }
}
