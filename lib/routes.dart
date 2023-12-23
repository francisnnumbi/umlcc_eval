import 'package:get/get.dart';
import 'package:umlcc_eval/app/ui/auth/login/login_page.dart';
import 'package:umlcc_eval/app/ui/auth/me/profile_page.dart';
import 'package:umlcc_eval/app/ui/auth/register/register_page.dart';
import 'package:umlcc_eval/app/ui/details/detail_page.dart';
import 'package:umlcc_eval/app/ui/details/detail_page.dart';

import 'app/middlewares/auth_middleware.dart';
import 'app/ui/home/home_page.dart';

class Routes {
  static List<GetPage> routes = [
    GetPage(
      name: LoginPage.route,
      page: () => LoginPage(),
    ),
    GetPage(
      name: RegisterPage.route,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: HomePage.route,
      page: () => const HomePage(),
      middlewares: [
        AuthMiddleware(priority: -1),
      ],
    ),
    GetPage(
      name: ProfilePage.route,
      page: () => const ProfilePage(),
      middlewares: [
        AuthMiddleware(priority: -1),
      ],
    ),
    GetPage(
      name: DetailPage.route,
      page: () => const DetailPage(),
      middlewares: [
        AuthMiddleware(priority: -1),
      ],
    ),
  ];
}
