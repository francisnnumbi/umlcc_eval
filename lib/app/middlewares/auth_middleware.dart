import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umlcc_eval/app/ui/auth/login/login_page.dart';
import 'package:umlcc_eval/app/ui/home/home_page.dart';

import '../services/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? priority = -99;

  AuthMiddleware({required this.priority});

  @override
  RouteSettings redirect(String? route) {
    if (kDebugMode) print('auth middleware : ${route!}');
    if (AuthService.to.isLogged == true) {
      return const RouteSettings(name: HomePage.route);
    } else {
      return const RouteSettings(name: LoginPage.route);
    }
  }
}
