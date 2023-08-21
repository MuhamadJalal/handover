import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

/*
here handle all width and height according to MediaQuery api to make out app design response

> 1200
> 600
> 300
*/
class SizeConfig {
  SizeConfig._internal();

  static final SizeConfig _instance = SizeConfig._internal();

  factory SizeConfig() => _instance;

  /// get the screen absolute Width depend on device rotation (if the rotate available)
  double screenWidth = Get.context?.orientation == Orientation.portrait ? Get.mediaQuery.size.width : Get.mediaQuery.size.height;

  /// get the screen absolute Height depend on device rotation (if the rotate available)
  double screenHeight = Get.context?.orientation == Orientation.portrait ? Get.mediaQuery.size.height : Get.mediaQuery.size.width;

  /// get the screen's single block Width (consider it as a Cell).
  /// Note: the percentage includes the horizontal device adding
  double blockSizeHorizontal() => screenWidth / 100;

  /// get the screen's single block Height (consider it as a Cell).
  /// Note: the percentage includes the vertical device adding
  double blockSizeVertical() => screenHeight / 100;

  /// get the screen's horizontal padding
  double _safeAreaHorizontal() => Get.mediaQuery.padding.left + Get.mediaQuery.padding.right;

  /// get the screen's vertical padding
  double _safeAreaVertical() => Get.mediaQuery.padding.top + Get.mediaQuery.padding.bottom;

  /// get the screen Horizontal percentage depend on the [screenWidth], [_safeAreaHorizontal] and [_safeAreaVertical]
  /// we can define any Widget width by multiple the single horizontal block [safeBlockHorizontal] by a num
  ///
  /// ex: width: 5 * SizeConfig().safeBlockHorizontal(),
  ///
  /// that means the widget's width will space a 5% of the device's screen width after removing the devices horizontal's padding
  ///
  /// to minify the usage see [FontSizeScaling]
  ///
  double safeBlockHorizontal() => (screenWidth - (Get.context?.orientation == Orientation.portrait ? _safeAreaHorizontal() : _safeAreaVertical())) / 100;

  /// get the screen Vertical percentage depend on the [screenWidth], [_safeAreaHorizontal] and [_safeAreaVertical]
  /// we can define any Widget height by multiple the single horizontal block [safeBlockVertical] by a num
  ///
  /// ex: height: 5 * SizeConfig().safeBlockVertical(),
  ///
  /// that means the widget's height will space a 5% of the device's screen height after removing the devices vertical's padding
  ///
  /// to minify the usage see [FontSizeScaling]
  ///
  double safeBlockVertical() => (screenHeight - (Get.context?.orientation == Orientation.portrait ? _safeAreaVertical() : _safeAreaHorizontal())) / 100;
}

// import 'package:device_info_plus/device_info_plus.dart';
// Future<bool> isIpad() async {
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   IosDeviceInfo info = await deviceInfo.iosInfo;
//
//   return info.model != null && info.model!.toLowerCase().contains("ipad");
// }
