import 'package:get/get.dart';
import 'package:umlcc_eval/api/endpoints.dart';

class ApiProvider2 extends GetConnect {
  static final ApiProvider2 api = ApiProvider2();

  // Register
  Future<Response> register(Map<String, dynamic> data) => post(
        EndPoint.registerUrl,
        data,
        headers: EndPoint.headers(),
      );

  // Login
  Future<Response> login(Map<String, dynamic> data) => post(
        EndPoint.loginUrl,
        data,
        headers: EndPoint.headers(),
      );

  // Verify
  Future<Response> verify(Map<String, dynamic> data) => post(
        EndPoint.verifyUrl,
        data,
        headers: EndPoint.headers(),
      );

// Me
  Future<Response> me() => get(
        EndPoint.meUrl,
        headers: EndPoint.headers(),
      );

  // Products
  Future<Response> products() => get(
        EndPoint.productsUrl,
        headers: EndPoint.headers(),
      );
}
