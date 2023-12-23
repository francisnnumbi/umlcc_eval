import 'package:cookie_jar/cookie_jar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:umlcc_eval/app/controllers/data_controller.dart';
import 'package:umlcc_eval/app/ui/splash/splash_page.dart';
import 'package:umlcc_eval/configs/constants.dart';
import 'package:umlcc_eval/routes.dart';

import 'api/firebase_api.dart';
import 'app/services/auth_service.dart';
import 'firebase_options.dart';

final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
final DIO = Dio();
final GetStorage InnerStorage = GetStorage(kAppName);

_retrieveDeviceInfo() async {
  final devInfo = await deviceInfoPlugin.deviceInfo;
  // if (kDebugMode) print(devInfo.data.toString());
  InnerStorage.write(kIdentity, devInfo.data['id'].toString());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DIO.interceptors.add(CookieManager(CookieJar()));
  //DIO.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  await GetStorage.init(kAppName);
  await _retrieveDeviceInfo();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  await _initServices();
  runApp(MyApp());
}

Future<void> _initServices() async {
  await AuthService.init();
  await DataController.init();
}

Future<void> _initControllers() async {
  await DataController.init();
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
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return GetMaterialApp(
      title: kAppName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: SplashPage.route,
      getPages: Routes.routes,
    );
  }
}
