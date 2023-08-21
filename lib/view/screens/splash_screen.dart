import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';
import 'package:handover/di/injector.dart';
import 'package:handover/helper/barrel_helper.dart';
import 'package:handover/view/common_widget/barrel_common_widget.dart';
import 'package:handover/view_model/barrel_view_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppRepoColors().appBackgroundColor,
        body: Stack(
          children: [
            GetBuilder<SplashScreenViewModel>(
              initState: (state) => getIt<SplashScreenViewModel>().initState(vsync: this),
              init: getIt<SplashScreenViewModel>(),
              builder: (controller) => AnimatedBuilder(
                animation: controller.animationController,
                builder: (context, child) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  constraints: const BoxConstraints.expand(),
                  color: controller.colorValue.value,
                  child: Center(
                    child: FadeIn(
                      duration: const Duration(milliseconds: 1400),
                      curve: Curves.easeIn,
                      controller: controller.fadeInController,
                      child: CustomImageProvider(
                        imagePath: AppRepoAssets().markerImage,
                        width: 65.safeBlockHorizontal(),
                        height: 65.safeBlockHorizontal(),
                        boxFit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
