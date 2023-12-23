import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/utils.dart';
import 'package:umlcc_eval/api/endpoints.dart';
import 'package:umlcc_eval/configs/constants.dart';
import 'package:umlcc_eval/main.dart';

class ApiProvider {
  static final ApiProvider api = ApiProvider();

  // Register
  Future<Response> register(Map<String, dynamic> data) => DIO.post(
        EndPoint.registerUrl,
        queryParameters: data,
        options: Options(headers: EndPoint.headers()),
      );

  // Login
  Future<Response> login(Map<String, dynamic> data) => DIO.post(
        EndPoint.loginUrl,
        queryParameters: data,
        options: Options(headers: EndPoint.headers()),
      );

  // Verify
  Future<Response> verify(Map<String, dynamic> data) {
    final h = EndPoint.headers(
      xDid: InnerStorage.read(kXDid).toString(),
      identity: InnerStorage.read(kIdentity).toString(),
    );
    if (kDebugMode) printInfo(info: "VERIFY HEADERS :: $h");
    return DIO.post(
      EndPoint.verifyUrl,
      queryParameters: data,
      options: Options(
        headers: h,
      ),
    );
  }

// Me
  Future<Response> me(String cookies) {
    final h = EndPoint.headers(
      xDid: InnerStorage.read(kXDid).toString(),
      token:
          '${InnerStorage.read(kTokenType).toString()} ${InnerStorage.read(kAccessToken).toString()}',
      cookies: cookies,
    );
    if (kDebugMode) printInfo(info: "ME HEADERS :: $h");
    return DIO.get(
      EndPoint.meUrl,
      options: Options(
        headers: h,
      ),
    );
  }

  // Products
  Future<Response> products(String cookies) => DIO.get(
        EndPoint.productsUrl,
        options: Options(
          headers: EndPoint.headers(
            xDid: InnerStorage.read(kXDid).toString(),
            token:
                '${InnerStorage.read(kTokenType).toString()} ${InnerStorage.read(kAccessToken).toString()}',
            cookies: cookies,
          ),
        ),
      );
}
