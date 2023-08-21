import 'dart:io';

import 'package:flutter/material.dart';
import 'package:handover/helper/barrel_helper.dart';

class CustomImageProvider extends StatelessWidget {
  final BoxFit? boxFit;
  final double? height;
  final double? width;
  final String imagePath;
  final BorderRadius? borderRadius;
  final void Function()? onTap;
  final bool? isBorderRadius;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final Widget? child;

  const CustomImageProvider(
      {Key? key, this.boxFit, this.height, this.width, required this.imagePath, this.borderRadius, this.onTap, this.isBorderRadius = true, this.margin, this.alignment, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          margin: margin,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: isBorderRadius! ? borderRadius : null,
            color: AppRepoColors().appTransparentColor,
            image: DecorationImage(
              image: (imagePath.isEmpty
                  ? AssetImage(AppRepoAssets().markerImage)
                  : imagePath.startsWith('http')
                      ? NetworkImage(imagePath)
                      : imagePath.startsWith('asset')
                          ? AssetImage(imagePath)
                          : FileImage((File(imagePath)))) as ImageProvider,
              fit: boxFit ?? BoxFit.fill,
              onError: (Object exception, StackTrace? stackTrace) => Icon(Icons.image, color: AppRepoColors().appRedColor.withOpacity(0.3), size: 20.safeBlockHorizontal()),
            ),
          ),
          child: child,
        ),
      );
}
