import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:handover/firebase_options.dart';
import 'package:handover/helper/barrel_helper.dart';
import 'package:handover/view_model/local_notification_view_model.dart';
import 'package:http/http.dart' as http;

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

const serverKey = 'AAAAq1SBNug:APA91bFP_IwMMwUUiGSRZJDUaliyemoFAOR9SbpIg4uvIzHZqfE-IZxuGOq9P9ZdIjzziWjVeadTAjP6xgHOuqre-nXQt_YB2EHDIvcSKdMTx3MXe2b9EQoAyxHkJSZ6CywmIt7RNUpN';

class FirebaseViewModel {
  FirebaseViewModel._internal();

  static final FirebaseViewModel _services = FirebaseViewModel._internal();

  factory FirebaseViewModel() => _services;

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

  void sendNotification({
    required String userToken,
    required String title,
    required String bodyMsg,
    String? fromEmail,
    String? fromName,
    dynamic complainantId,
  }) async {
    try {
      Map<String, dynamic> notification = {
        'body': bodyMsg,
        'title': title,
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'sound': 'default',
      };

      Map<String, dynamic> data = {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'type': 'delivery',
      };
      'sendNotification push notification notification $notification'.debug(this);
      'sendNotification push notification data $data'.debug(this);

      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'to': userToken,
            // 'to': userToken,
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'notification': notification,
            'data': data,
          },
        ),
      );
      'sendNotification push notification response ${response.body}'.debug(this);
    } catch (e) {
      'sendNotification error push notification e $e'.debug(this);
    }
  }

  notificationViewer({RemoteMessage? remoteMessage, bool background = false, required from}) {
    'notificationViewer({RemoteNotification? notificationModel}) RemoteMessage from $from ${remoteMessage?.toMap()}'.debug(this);
    // Clipboard.setData(ClipboardData(text: notificationModel != null ? notificationModel.toMap().toString() : 'Notification is NULL!')).then((value) => 'Copied!'.toast(indicatorColor: Colors.red));

    if (remoteMessage != null) LocalNotificationService().showNotification(remoteMessage, jsonEncode(remoteMessage.notification?.toMap()));
    // if (remoteMessage != null) {
    //   if (background) {
    //     LocalNotificationService().showNotification(remoteMessage, jsonEncode(remoteMessage.notification?.toMap()));
    //   } else {
    //     createAppDialog(child: NotificationAlert(notificationModel: remoteMessage.notification));
    //   }
    // }
  }
}
