import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umlcc_eval/app/ui/auth/login/login_page.dart';

import '../../configs/constants.dart';
import '../../main.dart';

class SplashMiddleware extends GetMiddleware {
  @override
  int? priority = -98;

  SplashMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (kDebugMode) print('splash middleware : ${route!}');
    if (!InnerStorage.hasData(kPhone) || !InnerStorage.hasData(kDialCode)) {
      return const RouteSettings(name: LoginPage.route);
    } else {
      return null;
    }
  }
}
