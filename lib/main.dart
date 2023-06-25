import 'package:core_project/Utill/Local_User_Data.dart';
 import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
 import 'Utill/Services_locator.dart';
import 'app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await globalAccountData.init();
  /// Define Notifications provider
  Services_locator().init();
  runApp(MyApp(),);
}