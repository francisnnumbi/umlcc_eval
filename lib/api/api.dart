import 'package:dio/dio.dart';
import 'package:umlcc_eval/api/endpoints.dart';
import 'package:umlcc_eval/main.dart';

class ApiProvider {
  static final ApiProvider api = ApiProvider();

  // Register
  Future<Response> register(Map<String, dynamic> data) => DIO.post(
        EndPoint.registerUrl,
        queryParameters: data,
        options: Options(
          headers: EndPoint.headers(),
        ),
      );

  // Login
  Future<Response> login(Map<String, dynamic> data) => DIO.post(
        EndPoint.loginUrl,
        data: data,
        options: Options(
          headers: EndPoint.headers(),
        ),
      );

  // Verify
  Future<Response> verify(Map<String, dynamic> data) => DIO.post(
        EndPoint.verifyUrl,
        data: data,
        options: Options(
          headers: EndPoint.headers(),
        ),
      );

// Me
  Future<Response> me() => DIO.get(
        EndPoint.meUrl,
        options: Options(
          headers: EndPoint.headers(),
        ),
      );

  // Products
  Future<Response> products() => DIO.get(
        EndPoint.productsUrl,
        options: Options(
          headers: EndPoint.headers(),
        ),
      );
}
