import 'package:flutter/material.dart';
import 'package:handover/helper/extensions/size_extension.dart';

class AppRepoSizes {
  AppRepoSizes._internal();

  static final AppRepoSizes _instance = AppRepoSizes._internal();

  factory AppRepoSizes() => _instance;

  BorderRadius circularCornerRadius = BorderRadius.circular(100.safeBlockHorizontal());
  BorderRadius defaultCardCornerRadius = BorderRadius.circular(4.safeBlockHorizontal());
  BorderRadius smallCardCornerRadius = BorderRadius.circular(1.safeBlockHorizontal());

  BorderRadius onlyRightCircularCornerRadius = BorderRadius.only(topRight: Radius.circular(100.safeBlockHorizontal()), bottomRight: Radius.circular(100.safeBlockHorizontal()));
  BorderRadius onlyLeftCircularCornerRadius = BorderRadius.only(bottomLeft: Radius.circular(100.safeBlockHorizontal()), topLeft: Radius.circular(100.safeBlockHorizontal()));

  BorderRadius onlyTopCircularCornerRadius = BorderRadius.only(topLeft: Radius.circular(8.safeBlockHorizontal()), topRight: Radius.circular(8.safeBlockHorizontal()));
}
