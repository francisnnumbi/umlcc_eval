import 'package:dio/dio.dart';
import 'package:umlcc_eval/api/endpoints.dart';
import 'package:umlcc_eval/configs/constants.dart';
import 'package:umlcc_eval/main.dart';

class ApiProvider {
  final Dio dio;

  ApiProvider(this.dio);

  // Register
  Future<Response> register(Map<String, dynamic> data) => dio.post(
        EndPoint.registerUrl,
        queryParameters: data,
        options: Options(headers: EndPoint.headers()),
      );

  // Login
  Future<Response> login(Map<String, dynamic> data) => dio.post(
        EndPoint.loginUrl,
        queryParameters: data,
        options: Options(headers: EndPoint.headers()),
      );

  // Verify
  Future<Response> verify(Map<String, dynamic> data) => dio.post(
        EndPoint.verifyUrl,
        queryParameters: data,
        options: Options(
          headers: EndPoint.headers(
            identity: InnerStorage.read(kIdentity).toString(),
          ),
        ),
      );

// Me
  Future<Response> me() => dio.get(
        EndPoint.meUrl,
        options: Options(
          headers: EndPoint.headers(
            identity: InnerStorage.read(kIdentity).toString(),
            token:
                '${InnerStorage.read(kTokenType).toString()} ${InnerStorage.read(kAccessToken).toString()}',
          ),
        ),
      );

  // Products
  Future<Response> products() => dio.get(
        EndPoint.productsUrl,
        options: Options(
          headers: EndPoint.headers(
            identity: InnerStorage.read(kIdentity).toString(),
            token:
                '${InnerStorage.read(kTokenType).toString()} ${InnerStorage.read(kAccessToken).toString()}',
          ),
        ),
      );
}
