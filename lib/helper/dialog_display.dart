import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';

createAppDialog({required Widget child}) => showAnimatedDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) => child,
      animationType: DialogTransitionType.rotate3D,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
    );
