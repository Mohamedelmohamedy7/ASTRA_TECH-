 import 'package:flutter/material.dart';
import 'package:get/get.dart';
   import '../Controllers/ThemeController.dart';
import '../Features/Login/view/LoginScreen.dart';
import '../Features/Screen/SplashScreen.dart';


class Routes {
  static const String splashRoute = "/";
  static const String welcomeRoute = "/Welcome";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
        case Routes.splashRoute:
          return MaterialPageRoute(builder: (_) => const SplashScreen());
        case Routes.loginRoute:
          return MaterialPageRoute(builder: (_) =>   LoginScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("No Route Found"),
              ),
              body: Builder(builder: (context) {
                return GestureDetector(
                    onTap: () {

                      Get.find<ThemeController>().toggleTheme();
                    },
                    child: const Center(
                        child: Text(
                      "" ,
                    )));
              }),
            ));
  }
}
