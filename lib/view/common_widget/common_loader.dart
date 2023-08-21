import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:handover/helper/barrel_helper.dart';
import 'package:handover/view/common_widget/common_text.dart';

class CustomLoader extends StatelessWidget {
  final String? text;
  const CustomLoader({super.key, this.text});

  @override
  Widget build(BuildContext context) => Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 1.5.safeBlockHorizontal(),
                top: 1.5.safeBlockHorizontal(),
                right: 1.5.safeBlockHorizontal(),
                bottom: 1.5.safeBlockHorizontal(),
              ),
              width: 14.safeBlockHorizontal(),
              height: 14.safeBlockHorizontal(),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppRepoColors().appPrimaryColor),
                backgroundColor: AppRepoColors().appLoaderBorderColor,
                strokeWidth: 1.safeBlockHorizontal(),
              ),
            ),
            Container(
              width: 10.safeBlockHorizontal(),
              height: 10.safeBlockHorizontal(),
              alignment: Alignment.center,
              child: ClipOval(
                child: CustomText(
                  text: (text ?? AppTranslations.title.characters.first).capitalize,
                  textAlign: TextAlign.center,
                  fontSize: 4.fontSize(),
                  fontWeight: FontWeight.w400,
                  textColor: AppRepoColors().appFontBlackColor,
                ),
              ),
            )
          ],
        ),
      );
}
