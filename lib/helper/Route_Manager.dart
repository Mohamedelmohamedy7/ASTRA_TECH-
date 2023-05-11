import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/theme_provider.dart';
import '../Screen/LoginScreen.dart';
import '../Screen/SplashScreen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String welcomeRoute = "/Welcome";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String addressRoute = "/address";
  static const String registerRoute = "/register";
  static const String verifyRoute = "/verify";
  static const String homeRoute = "/home";
  static const String internalWelcomeRoute = "/internalWelcome";
  static const String tabBarRoute = "/tabBar";
  static const String categoriesRoute = "/categories";
  static const String myLocation = "/location";
  static const String mapRoute = "/mapScreen";
  static const String cartRoute = "/CartScreen";
  static const String checkoutRoute = "/CheckOutScreen";
  static const String noInternetScreenRoute = "/NoInternetScreen";
  static const String languageRoute = "/LanguageScreen";
  static const String settingRoute = "/Setting";
  static const String updateSettingRoute = "/UpdateSetting";
  static const String successRoute = "/successScreen";
  static const String favoriteRoute = "/FavoriteScreen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
        case Routes.splashRoute:
          return MaterialPageRoute(builder: (_) => const SplashScreen());
      //   case Routes.myLocation:
      //     return MaterialPageRoute(builder: (_) => const MyLocationScreen());
      //   case Routes.languageRoute:
      //     return MaterialPageRoute(builder: (_) => const LanguageScreen());
      //   case Routes.updateSettingRoute:
      //     return MaterialPageRoute(builder: (_) => const UpdateScreen());
      //   case Routes.noInternetScreenRoute:
      //     return MaterialPageRoute(builder: (_) => const NoInternetScreen());
      //   case Routes.cartRoute:
      //     return MaterialPageRoute(builder: (_) => const CartScreen());
        case Routes.loginRoute:
          return MaterialPageRoute(builder: (_) =>   LoginScreen());
      //   case Routes.onBoardingRoute:
      //     return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      //   case Routes.categoriesRoute:
      //     return MaterialPageRoute(builder: (_) =>   CategoriesScreen(type: 0,));
      //   case Routes.verifyRoute:
      //     return MaterialPageRoute(builder: (_) => const VertifyScreen());
      //   case Routes.registerRoute:
      //     return MaterialPageRoute(builder: (_) => const RegisterScreen(email: '',));
      //   case Routes.homeRoute:
      //     return MaterialPageRoute(builder: (_) => const HomeScreen());
      //   case Routes.internalWelcomeRoute:
      //     return MaterialPageRoute(builder: (_) => const WelcomInternal());
      //   case Routes.welcomeRoute:
      //     return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      //   case Routes.tabBarRoute:
      //     return MaterialPageRoute(builder: (_) => const TabBarScreen());
      //   case Routes.settingRoute:
      //     return MaterialPageRoute(builder: (_) =>   SettingScreen());
      // case Routes.favoriteRoute:
      //     return MaterialPageRoute(builder: (_) => const FavoriteScreen());
      //   case Routes.checkoutRoute:
      //     return MaterialPageRoute(builder: (_) =>  CheckOutScreen());
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
                      print(Provider.of<ThemeProvider>(context, listen: false)
                          .darkTheme);
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                      print(Provider.of<ThemeProvider>(context, listen: false)
                          .darkTheme);
                    },
                    child: Center(
                        child: Text(
                      "Carats".tr(),
                    )));
              }),
            ));
  }
}
