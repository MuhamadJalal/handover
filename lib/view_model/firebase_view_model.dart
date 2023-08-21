import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:handover/firebase_options.dart';
import 'package:handover/helper/barrel_helper.dart';
import 'package:handover/view/common_widget/notification_alert_widget.dart';
import 'package:handover/view_model/local_notification_view_model.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  //
  // LocalNotificationService().initializeLocalNotification();
  //
  // FirebaseServices().notificationViewer(remoteMessage: message, background: true, from: '_firebaseMessagingBackgroundHandler');
  return;
}

class FirebaseServices {
  FirebaseServices._internal();

  static final FirebaseServices _services = FirebaseServices._internal();

  factory FirebaseServices() => _services;

  signOutFirebase() async => await FirebaseMessaging.instance.deleteToken();

  Future<String?> getUserToken() async => await FirebaseMessaging.instance.getToken();

  firebaseInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.setAutoInitEnabled(false);

    LocalNotificationService().initializeLocalNotification();

    startFirebaseMessaging();

    if (GetPlatform.isAndroid) FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  stopFirebaseMessaging() async {
    await FirebaseMessaging.instance.deleteToken();
  }

  startFirebaseMessaging() => getUserToken().then((userToken) {
        'FirebaseServices().getToken: $userToken'.debug(this);

        // postAddToken(userToken: userToken);
/*
{
  title: المساءلات,
  titleLocArgs: [],
  titleLocKey: null،
  body: تم إضافة مساءلة جدبدة,
  bodyLocArgs: [],
  bodyLocKey: null,
  apple: null,
  web: null
  android: {
    channelId: null,
    clickAction: null,
    color: null,
    count: null,
    imageUrl: null,
    priority: 0,
    smallIcon: null,
    sound: null,
    ticker: null,
    tag: null,
    visibility: 0
  },
}

* */
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          'FirebaseMessaging message: $message'.debug(this);
          'FirebaseMessaging message.data: ${message.data}'.debug(this);
          'FirebaseMessaging message.notification: ${message.notification}'.debug(this);
          'FirebaseMessaging message.notification.body: ${message.notification?.body}'.debug(this);
          'FirebaseMessaging message.notification.title: ${message.notification?.title}'.debug(this);
          // notificationModel.value = notificationModelFromJson(message.data);
          // 'FirebaseMessaging notificationModel.value: ${notificationModel.}'.debug(this);

          notificationViewer(remoteMessage: message, from: 'FirebaseMessaging.onMessage');
        });

        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          'FirebaseMessaging onMessageOpenedApp: ${message.data}'.debug(this);
          // notificationModel.value = notificationModelFromJson(message.data);
          notificationViewer(remoteMessage: message, from: 'FirebaseMessaging.onMessageOpenedApp');
        });

        FirebaseMessaging.onBackgroundMessage((RemoteMessage message) {
          'FirebaseMessaging onMessageOpenedApp: ${message.data}'.debug(this);
          // notificationModel.value = notificationModelFromJson(message.data);
          return notificationViewer(remoteMessage: message, from: 'FirebaseMessaging.onBackgroundMessage');
        });
      });

  notificationViewer({RemoteMessage? remoteMessage, bool background = false, required from}) {
    'notificationViewer({RemoteNotification? notificationModel}) RemoteMessage from $from ${remoteMessage?.toMap()}'.debug(this);
    // Clipboard.setData(ClipboardData(text: notificationModel != null ? notificationModel.toMap().toString() : 'Notification is NULL!')).then((value) => 'Copied!'.toast(indicatorColor: Colors.red));

    if (remoteMessage != null) {
      if (background) {
        LocalNotificationService().showNotification(remoteMessage, jsonEncode(remoteMessage.notification?.toMap()));
      } else {
        createAppDialog(child: NotificationAlert(notificationModel: remoteMessage.notification));
      }
    }
  }
}
