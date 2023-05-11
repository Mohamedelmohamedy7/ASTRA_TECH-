import 'package:core_project/Provider/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/LoginProvider.dart';
import 'Utill/Notifications/notification.dart';
import 'app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /// Define Notifications provider
  mainFunctionForNotification();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ListenableProvider<LoginProvider>(create: (_) => LoginProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('en', 'GB')],
        path: 'assets/trasnlation',
        saveLocale: true,
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      )));
}
