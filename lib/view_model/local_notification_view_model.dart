import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:handover/helper/barrel_helper.dart';
import 'package:handover/models/barrel_models.dart';
import 'package:rxdart/rxdart.dart';

class LocalNotificationService {
  LocalNotificationService._internal();

  static final LocalNotificationService _localNotificationService = LocalNotificationService._internal();

  factory LocalNotificationService() => _localNotificationService;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();

  static final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();
  static late String? selectedNotificationPayload;

  initializeLocalNotification() {
    /// init flutter locale notification
    initFLN();
    requestPermissions();
    configureDidReceiveLocalNotificationSubject();
    // configureSelectNotificationSubject();
  }

  @pragma('vm:entry-point')
  static void onDidReceiveBackgroundNotificationResponse(NotificationResponse notificationResponse) async {
    selectedNotificationPayload = notificationResponse.payload;
    'onDidReceiveBackgroundNotificationResponse notificationResponse data: ${notificationResponse.notificationResponseType} '
            '- ${notificationResponse.id}'
            '- ${notificationResponse.actionId}'
            '- ${notificationResponse.input}'
            '- ${notificationResponse.payload}'
            ''
        .debug('static this');

    if (notificationResponse.payload != null && notificationResponse.payload!.isNotEmpty) {
      // var notificationPayload = jsonDecode(notificationResponse.payload!);

      'await flutterLocalNotificationsPlugin.initialize onDidReceiveBackgroundNotificationResponse jsonDecode(notificationResponse.payload!) ${jsonDecode(notificationResponse.payload!)}'
          .debug('static this');
      'await flutterLocalNotificationsPlugin.initialize onDidReceiveBackgroundNotificationResponse jsonDecode(notificationResponse.payload!) notification ${jsonDecode(notificationResponse.payload!)['notification']}'
          .debug('static this');

      selectNotificationSubject.add(notificationResponse.payload!);
    }
  }

  Future<void> initFLN() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload = notificationAppLaunchDetails?.notificationResponse?.payload;
    }

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
          if (title != null && title.isNotEmpty && body != null && body.isNotEmpty && payload != null && payload.isNotEmpty) {
            didReceiveLocalNotificationSubject.add(ReceivedNotification(id: id, title: title, body: body, payload: payload));
          }
        });

    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
      selectedNotificationPayload = notificationResponse.payload;
      'onDidReceiveNotificationResponse notificationResponse data: ${notificationResponse.notificationResponseType} '
              '- ${notificationResponse.id}'
              '- ${notificationResponse.actionId}'
              '- ${notificationResponse.input}'
              '- ${notificationResponse.payload}'
              ''
          .debug(this);

      if (notificationResponse.payload != null && notificationResponse.payload!.isNotEmpty) {
        var notificationPayload = jsonDecode(notificationResponse.payload!);

        'await flutterLocalNotificationsPlugin.initialize onDidReceiveNotificationResponse notificationPayload $notificationPayload'.debug(this);

        selectNotificationSubject.add(notificationResponse.payload!);
      }
    });
  }

  // void configureSelectNotificationSubject() => selectNotificationSubject.stream.listen(showNotification);

  void configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream.listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: Get.context!,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(receivedNotification.title),
          content: Text(receivedNotification.body),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {},
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  Future<void> requestPermissions() async {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  /// todo RemoteMessage remoteMessage
  Future<void> showNotification(RemoteMessage remoteMessage, String notificationMsg) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description', importance: Importance.max, priority: Priority.high, fullScreenIntent: true, ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    // _configureLocalTimeZone();

    'Future<void> showNotification(String notificationMsg $notificationMsg'.debug(this);
    'Future<void> showNotification(String remoteMessage ${remoteMessage.toMap()}'.debug(this);

    /*
    {
        title: المساءلات, titleLocArgs: [], titleLocKey: null, body: تم إضافة مساءلة جدبدة, bodyLocArgs: [], bodyLocKey: null,
        android: {channelId: null, clickAction: null, color: null, count: null, imageUrl: null,
        apple: null, web: null
    }
    * */

    if (notificationMsg.toLowerCase().contains('android') || notificationMsg.toLowerCase().contains('apple')) {
      var notificationPayload = jsonDecode(notificationMsg);
      if (notificationPayload is Map<String, dynamic> && notificationPayload.containsKey('title') && notificationPayload.containsKey('body')) {
        await FlutterLocalNotificationsPlugin()
            .show(0, notificationPayload['title'] ?? AppTranslations.title, notificationPayload['body'] ?? '', platformChannelSpecifics, payload: jsonEncode(remoteMessage.toMap()));
      } else {
        await FlutterLocalNotificationsPlugin().show(0, AppTranslations.title, '', platformChannelSpecifics, payload: jsonEncode(remoteMessage.toMap()));
      }
    } else {
      await FlutterLocalNotificationsPlugin().show(0, AppTranslations.title, notificationMsg, platformChannelSpecifics, payload: jsonEncode(remoteMessage.toMap()));
    }
  }

// Future<void> _configureLocalTimeZone() async {
//   '_configureLocalTimeZone DateTime.now().timeZoneName ${DateTime.now().timeZoneName}'.debug(this);
//   tz_latest.initializeTimeZones();
//   timezone.setLocalLocation(timezone.getLocation('America/Detroit'));
// }
}
/*

E/flutter (30480): [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: Null check operator used on a null value
E/flutter (30480): #0      MethodChannelFirebaseMessaging.registerBackgroundMessageHandler (package:firebase_messaging_platform_interface/src/method_channel/method_channel_messaging.dart:181)
E/flutter (30480): #1      FirebaseMessagingPlatform.onBackgroundMessage= (package:firebase_messaging_platform_interface/src/platform_interface/platform_interface_messaging.dart:102)
E/flutter (30480): #2      FirebaseMessaging.onBackgroundMessage (package:firebase_messaging/src/messaging.dart:73)
E/flutter (30480): #3      FirebaseServices.firebaseInit (package:handover/view_model/firebase_view_model.dart:45)
E/flutter (30480): <asynchronous suspension>
E/flutter (30480):
E/flutter (30480): [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: Null check operator used on a null value
E/flutter (30480): #0      _evaluateBackgroundNotificationCallback (package:flutter_local_notifications/src/platform_flutter_local_notifications.dart:1026)
E/flutter (30480): #1      AndroidFlutterLocalNotificationsPlugin.initialize (package:flutter_local_notifications/src/platform_flutter_local_notifications.dart:148)
E/flutter (30480): #2      FlutterLocalNotificationsPlugin.initialize (package:flutter_local_notifications/src/flutter_local_notifications_plugin.dart:142)
E/flutter (30480): #3      LocalNotificationService.initFLN (package:handover/view_model/local_notification_view_model.dart:59)
E/flutter (30480): <asynchronous suspension>
            * */
