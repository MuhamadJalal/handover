import 'package:get/get.dart';
import 'package:handover/helper/size_config.dart';

/// depend on the [SizeConfig] file
/// we can define any Widget height and width, and also the font size by the following extensions
extension FontSizeScaling on num {
  /// [fontSize] define any font size by multiple it by a num
  /// ex: fontSize: 4.5.fontSize(),
  ///
  /// that means the fontSize will space a 4.5% of the device's screen width
  ///
  fontSize() => Get.mediaQuery.size.width > 600 ? SizeConfig().safeBlockHorizontal() * this * .7 : SizeConfig().safeBlockHorizontal() * this;

  /// [safeBlockHorizontal] define any widths by multiple it by a num
  /// ex: width: 45.safeBlockHorizontal(),
  ///
  /// that means the widget's width will space a 45% of the device's screen width after removing the devices horizontal's padding
  ///
  safeBlockHorizontal() => Get.mediaQuery.size.width > 600 ? SizeConfig().safeBlockHorizontal() * this * .7 : SizeConfig().safeBlockHorizontal() * this;

  /// [safeBlockHorizontal] define any widths by multiple it by a num
  /// ex: width: 45.safeBlockHorizontal(),
  ///
  /// that means the widget's width will space a 45% of the device's screen width including the devices horizontal's padding area
  ///
  blockSizeHorizontal() => Get.mediaQuery.size.width > 600 ? SizeConfig().blockSizeHorizontal() * this : SizeConfig().blockSizeHorizontal() * this;

  /// [safeBlockVertical] define any heights by multiple it by a num
  /// ex: height: 45.safeBlockVertical(),
  ///
  /// that means the widget's height will space a 45% of the device's screen height after removing the devices vertical's padding
  ///
  safeBlockVertical() => Get.mediaQuery.size.width > 600 ? SizeConfig().safeBlockVertical() * this * 1 : SizeConfig().safeBlockVertical() * this;

  /// [blockSizeVertical] define any heights by multiple it by a num
  /// ex: height: 45.blockSizeVertical(),
  ///
  /// that means the widget's height will space a 45% of the device's screen height including the devices vertical's padding area
  ///
  blockSizeVertical() => Get.mediaQuery.size.width > 600 ? SizeConfig().blockSizeVertical() * this * .9 : SizeConfig().blockSizeVertical() * this;
}
