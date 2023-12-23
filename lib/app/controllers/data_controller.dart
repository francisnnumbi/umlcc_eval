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

  selectProduct(Product p0) {
    product.value = p0;
    Get.toNamed(DetailPage.route);
  }

  Future<void> loadProducts() async {
    ApiProvider.api.products().then((response) {
      if (response.statusCode == 200) {
        final data = response.data;
        products.value = Product.listFromJson(data['data']);
      }
    }).onError((error, stackTrace) {
      printError(info: "LOAD PRODUCTS :: $error");
    });
  }

  @override
  void onReady() {
    super.onReady();
    AuthService.to.user.listen((p0) {
      if (p0 != null) {
        loadProducts();
      }
    });
  }
}
