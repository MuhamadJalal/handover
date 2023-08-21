import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';
import 'package:handover/helper/app_repo_constants/app_repo_colors.dart';
import 'package:handover/view/screens/home_screens/home_screen.dart';

class SplashScreenViewModel extends GetxController {
  late AnimationController animationController;
  final fadeInController = FadeInController();

  final int waitTillNextPage = 60;
  Rx<Color> colorValue = Rx(AppRepoColors().appPrimaryColor);

  Future goToNextPage() async => Future.delayed(
        Duration(milliseconds: waitTillNextPage),
        () => Get.offAll(const HomeScreen(), transition: Transition.fadeIn),
      );

  initState({required TickerProvider vsync}) {
    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1200),
    );
    animationController.forward().whenComplete(() {
      colorValue.value = AppRepoColors().appBlackColor;
      update();
      fadeInController.fadeIn();
    }).then((value) => Future.delayed(const Duration(milliseconds: 3300), goToNextPage));
  }
}
