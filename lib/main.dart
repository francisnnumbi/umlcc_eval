import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:umlcc_eval/app/controllers/auth_controller.dart';
import 'package:umlcc_eval/configs/constants.dart';
import 'package:umlcc_eval/routes.dart';

import 'app/ui/home/home_page.dart';

final DIO = Dio();
final GetStorage InnerStorage = GetStorage(kAppName);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(kAppName);
  runApp(MyApp());
}

Future<void> _initControllers() async {
  await AuthController.init();
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    _initControllers();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return GetMaterialApp(
      title: kAppName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: HomePage.route,
      getPages: Routes.routes,
    );
  }
}
