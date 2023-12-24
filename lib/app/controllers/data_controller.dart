import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umlcc_eval/app/models/product.dart';
import 'package:umlcc_eval/app/services/auth_service.dart';
import 'package:umlcc_eval/app/ui/details/detail_page.dart';

import '../../api/api.dart';

class DataController extends GetxController {
  // ------- static methods ------- //
  static DataController get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<DataController>(() async => DataController());
  }

// ------- ./static methods ------- //
  final Rxn<List<Product>> products = Rxn<List<Product>>();
  final Rxn<Product> product = Rxn<Product>();

  selectProduct(Product product) {
    this.product.value = product;
    Get.toNamed(DetailPage.route);
  }

  Future<void> loadProducts({bool? notify = false}) async {
    ApiProvider.api.products().then((response) {
      if (response.statusCode == 200) {
        final data = response.data;
        products.value = Product.listFromJson(data['data']);
        if (notify == true) {
          Get.snackbar(
            "Data Loaded",
            data['message'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.shade900,
            colorText: Colors.white,
          );
        }
      } else {
        if (notify == true) {
          Get.snackbar(
            "Data Load Failed",
            response.data['message'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange.shade900,
            colorText: Colors.white,
          );
        }
        if (kDebugMode) {
          printError(info: "LOAD PRODUCTS :: ${response.statusCode}");
        }
      }
    }).onError((error, stackTrace) {
      if (notify == true) {
        Get.snackbar(
          "Connection Failed",
          error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade900,
          colorText: Colors.white,
        );
      }
      if (kDebugMode) printError(info: "LOAD PRODUCTS :: $error");
    });
  }

  @override
  void onReady() {
    super.onReady();
    AuthService.to.user.listen((user) {
      if (user != null) {
        loadProducts();
      }
    });
  }
}
