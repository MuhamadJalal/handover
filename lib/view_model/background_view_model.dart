import 'dart:async';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:get/get.dart';
import 'package:handover/view_model/local_notification_view_model.dart';

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  /// todo here add logic to store ongoing location changes
  return true;
}

@pragma('vm:entry-point')
Future<void> onServiceInstanceStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  String contentMsg = 'Sabbar ${DateTime.now()}';

  RemoteMessage remoteMessage = RemoteMessage.fromMap({
    'senderId': '${DateTime.now()}',
    'category': 'service',
    'collapseKey': 'collapseKey',
    'contentAvailable': true,
    'data': {'title': 'Sabbar', 'body': 'Sabbar ${DateTime.now()}'},
    'from': 'self',
    'messageId': '${DateTime.now()}',
    'messageType': 'service',
    'mutableContent': true,
    'notification': {'title': 'Sabbar', 'body': 'Sabbar ${DateTime.now()}'},
    // 'sentTime': DateTime.now(),
  });

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        // bring to foreground
        Timer.periodic(const Duration(seconds: 2), (timer) async {
          LocalNotificationService().showNotification(remoteMessage, contentMsg);
        });

        // if you don't using custom notification, uncomment this
        service.setForegroundNotificationInfo(
          title: "Sabbar Service",
          content: "Updated at ${DateTime.now()}",
        );
      }
    }
  });
}

class BackgroundViewModel extends GetxController {
  LocalNotificationService localNotificationService = LocalNotificationService();

  initState() async {
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onServiceInstanceStart,
        autoStart: true,
        isForegroundMode: false,
        // notificationChannelId: 'io.share.handover',
        initialNotificationTitle: 'Sabbar SERVICE',
        initialNotificationContent: 'Initializing',
        foregroundServiceNotificationId: await localNotificationService.notificationNo(),
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onBackground: onIosBackground,
        // onForeground: onServiceInstanceStart,
      ),
    );
    if (!(await service.isRunning())) service.startService();
  }
}
