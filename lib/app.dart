import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/theme_provider.dart';
import 'helper/Route_Manager.dart';
import 'helper/theme/dark_theme.dart';
import 'helper/theme/light_theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      initialRoute: Routes.splashRoute,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

