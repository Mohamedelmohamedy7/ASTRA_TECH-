import 'dart:developer';

import 'package:core_project/Utill/Comman.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../app.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
    // description
  description:'This channel is used for important notifications.',
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
AppLifecycleState appLifecycleState = AppLifecycleState.detached;
String token = "";

getToken() async {

  token = (await FirebaseMessaging.instance.getToken())!;
  talker.info("[ App token: $token ]");
  return token;
}

Future<void> onSelectNotification(String? payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
}


/// For main.dart
mainFunctionForNotification() async {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  await flutterLocalNotificationsPlugin
      ?.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .createNotificationChannel(channel);
  if (appLifecycleState == AppLifecycleState.inactive ||
      appLifecycleState == AppLifecycleState.paused ||
      appLifecycleState == AppLifecycleState.detached) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}
/// For Splash screen
appNotificationDialogFunctions()async{
  getToken();
  var initializationSettingsAndroid =
  const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      // Show a notification
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel id',
            'your channel name',
           channelDescription:  'your channel description',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );

      // Show a dialog
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: navigatorKey.currentContext!,
          builder: (_) {
            return MaterialApp(
              home: AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      showDialog(
          context: navigatorKey.currentContext!,
          builder: (_) {
            return MaterialApp(
              home: AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!),
                    Row(children: [
                      Text(notification.title!),
                      Text(notification.body!),
                    ],)

                    ],
                  ),
                ),
              ),
            );
          }) ;
    }
  });

}