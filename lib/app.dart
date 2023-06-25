 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'Controllers/ThemeController.dart';
import 'helper/Route_Manager.dart';
import 'helper/theme/dark_theme.dart';
import 'helper/theme/light_theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  final ThemeController registerController = Get.put(ThemeController());

    MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      theme:  Get.find<ThemeController>().darkTheme ? dark : light,
      initialRoute: Routes.splashRoute,
    );
  }
}

