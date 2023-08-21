import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handover/helper/barrel_helper.dart';
import 'package:handover/view/common_widget/barrel_common_widget.dart';
import 'package:handover/view/common_widget/common_text.dart';

class NotificationAlert extends StatelessWidget {
  final RemoteNotification? notificationModel;

  const NotificationAlert({Key? key, this.notificationModel}) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoAlertDialog(
        title: Material(
          color: AppRepoColors().kDialogColor,
          child: CustomText(
            text: notificationModel?.title ?? '',
            textColor: AppRepoColors().appFontBlackColor,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            fontSize: 5.0.fontSize(),
            maxLines: '${notificationModel?.title} '.length,
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
                    text: notificationModel?.body ?? '',
                    textColor: AppRepoColors().appFontBlackColor,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                    fontSize: 4.0.fontSize(),
                    maxLines: '${notificationModel?.body} '.length,
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
                onTap: Get.back,
                text: AppTranslations.cancel.capitalize!,
                textColor: AppRepoColors().appFontBlackColor,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
                fontSize: 5.0.fontSize(),
              ),
            ),
          ),
          Material(
            color: AppRepoColors().kDialogColor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.5.safeBlockVertical()),
              child: CustomText(
                onTap: () {},
                text: AppTranslations.submit.capitalize!,
                textColor: AppRepoColors().appFontGreenColor,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
                fontSize: 5.0.fontSize(),
              ),
            ),
          )
        ],
      );
}
