import 'dart:async';

import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:handover/helper/app_localization/localizations.dart';
import 'package:handover/helper/app_repo_constants/app_repo_colors.dart';
import 'package:handover/helper/extensions/size_extension.dart';
import 'package:handover/view/common_widget/barrel_common_widget.dart';
import 'package:handover/view/common_widget/common_text.dart';

extension FlutterToastExtension on String {
  Future errorToast({Color? indicatorColor}) => showAnimatedDialog(
        context: Get.context!,
        barrierDismissible: true,
        animationType: DialogTransitionType.rotate3D,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 500),
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Material(
            color: AppRepoColors().kDialogColor,
            child: CustomText(
              text: AppTranslations.error.capitalizeFirst,
              textAlign: TextAlign.center,
              fontSize: 4.0.fontSize(),
              fontWeight: FontWeight.w600,
              textColor: AppRepoColors().appFontBlackColor,
            ),
          ),
          content: Material(
            color: AppRepoColors().kDialogColor,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.safeBlockVertical()),
                    child: CustomText(
                      text: this,
                      textAlign: TextAlign.center,
                      fontSize: 3.0.fontSize(),
                      fontWeight: FontWeight.w400,
                      textColor: AppRepoColors().appFontBlackColor,
                      maxLines: ' $this '.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Material(
              color: AppRepoColors().kDialogColor,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.5.safeBlockVertical()),
                child: CustomText(
                  text: AppTranslations.ok.capitalizeFirst,
                  textAlign: TextAlign.center,
                  fontSize: 3.3.fontSize(),
                  fontWeight: FontWeight.w400,
                  textColor: AppRepoColors().appFontGreyColor,
                  onTap: Get.back,
                ),
              ),
            ),
          ],
        ),
      );

  Future textToast({Color? indicatorColor}) => showFlash(
        context: Get.context!,
        duration: const Duration(seconds: 6),
        builder: (context, controller) => Flash(
          controller: controller,
          dismissDirections: const [FlashDismissDirection.startToEnd, FlashDismissDirection.endToStart],
          position: FlashPosition.top,
          child: FlashBar(
            controller: controller,
            backgroundColor: indicatorColor ?? AppRepoColors().appBlueColor,
            content: CustomText(
              text: this,
              textAlign: TextAlign.center,
              fontSize: 4.fontSize(),
              fontWeight: FontWeight.w400,
              textColor: AppRepoColors().appFontWhiteColor,
              maxLines: '$this '.length,
            ),
            icon: Icon(Icons.info_outline, color: AppRepoColors().appWhiteColor),
            indicatorColor: AppRepoColors().appBlackColor,
          ),
        ),
      );
}
