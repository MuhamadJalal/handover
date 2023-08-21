import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handover/helper/barrel_helper.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? fontHeight;
  final Color? textColor;
  final Color? decorationColor;
  final double? decorationThickness;
  final TextDecoration? textDecoration;
  final void Function()? onTap;

  const CustomText(
      {Key? key,
      this.text,
      this.textAlign,
      this.fontSize,
      this.fontHeight,
      this.maxLines,
      this.fontWeight,
      this.textColor,
      this.decorationColor,
      this.decorationThickness,
      this.textDecoration,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Text(
          text ?? '',
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              height: fontHeight ?? (Get.mediaQuery.size.width > 600 ? 0.2 : 0.4).safeBlockHorizontal(),
              decoration: textDecoration,
              decorationThickness: decorationThickness,
              decorationColor: decorationColor ?? AppRepoColors().appWhiteColor,
              color: textColor ?? AppRepoColors().appWhiteColor),
        ),
      );
}
