import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:handover/di/injector.dart';
import 'package:handover/helper/barrel_helper.dart';
import 'package:handover/view/screens/splash_screen.dart';
import 'package:handover/view_model/barrel_view_model.dart';
import 'package:handover/view_model/firebase_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*
    * This will make splash screen lasts for the duration of the delay task.
    * 300ms looks well for me, can adjust based on your preference.
  */
  await Future.delayed(const Duration(milliseconds: 300));

  FirebaseViewModel().firebaseInit();

  await injectorSetup();

  /// start background services
  await getIt<BackgroundViewModel>().initState();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    GetMaterialApp(
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      onGenerateTitle: (_) => AppTranslations.title,
      locale: AppTranslations.locale,
      fallbackLocale: AppTranslations.fallbackLocale,
      theme: ThemeData(fontFamily: 'LamaSans'),
      initialBinding: BindingsBuilder(() => getIt<SplashScreenViewModel>()),
    ),
  );
}
