import 'package:flutter/material.dart';
import 'package:handover/helper/barrel_helper.dart';
import 'package:handover/view/common_widget/barrel_common_widget.dart';

class LabelWidget extends StatelessWidget {
  final String? title;
  final String? value;

  const LabelWidget({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 4.safeBlockHorizontal()),
          CustomText(
            text: title,
            textAlign: TextAlign.center,
            fontSize: 4.0.fontSize(),
            fontWeight: FontWeight.w600,
            textColor: AppRepoColors().appFontBlackColor,
          ),
          Expanded(child: SizedBox(width: 4.safeBlockHorizontal())),
          CustomText(
            text: value,
            textAlign: TextAlign.center,
            fontSize: 4.0.fontSize(),
            fontWeight: FontWeight.w400,
            textColor: AppRepoColors().appFontBlackColor,
          ),
          SizedBox(width: 4.safeBlockHorizontal()),
        ],
      );
}
