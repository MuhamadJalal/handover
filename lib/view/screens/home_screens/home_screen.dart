import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handover/di/injector.dart';
import 'package:handover/helper/barrel_helper.dart';
import 'package:handover/view/common_widget/barrel_common_widget.dart';
import 'package:handover/view/screens/map_screens/map_screen.dart';
import 'package:handover/view_model/barrel_view_model.dart';

class HomeScreen extends GetView<BusDriversViewModel> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<BusDriversViewModel>(
        init: getIt<BusDriversViewModel>(),
        initState: getIt<BusDriversViewModel>().initState,
        builder: (userLocationViewModel) => Scaffold(
          backgroundColor: AppRepoColors().appBackgroundColor,
          body: Container(
            width: 100.safeBlockHorizontal(),
            padding: EdgeInsets.all(4.safeBlockHorizontal()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 7.safeBlockVertical()),
                Row(
                  children: [
                    CustomText(
                      text: AppTranslations.currentOrder.capitalize!,
                      textAlign: TextAlign.start,
                      fontSize: 4.fontSize(),
                      fontWeight: FontWeight.w500,
                      textColor: AppRepoColors().appFontGreyColor,
                    ),
                  ],
                ),
                SizedBox(height: 7.safeBlockVertical()),
                CustomRoundedWidgetButton(
                  width: 80.safeBlockHorizontal(),
                  // height: 7.safeBlockVertical(),
                  alignment: Alignment.center,
                  backgroundColor: AppRepoColors().appWhiteColor,
                  borderRadius: AppRepoSizes().defaultCardCornerRadius,
                  padding: EdgeInsets.all(4.safeBlockHorizontal()),
                  margin: EdgeInsets.symmetric(vertical: 1.safeBlockVertical()),
                  child: Column(
                    children: [
                      CustomText(
                        text: 'By clicking the button blow you will be redirect ot the map screen\nwhere you can find these tow LatLong signed by a radial markers'
                            '\nLatLng(24.648775686213718, 46.94957966390889) as pickup point and\nLatLng(24.88811243373081, 46.55982427899553) as delivery point',
                        textAlign: TextAlign.start,
                        fontSize: 4.fontSize(),
                        fontWeight: FontWeight.w500,
                        textColor: AppRepoColors().appFontGreyColor,
                        maxLines: 100,
                      ),
                      SizedBox(height: 4.safeBlockVertical()),
                      CustomRoundedWidgetButton(
                        alignment: Alignment.center,
                        backgroundColor: AppRepoColors().appPrimaryColor,
                        borderRadius: AppRepoSizes().defaultCardCornerRadius,
                        padding: EdgeInsets.symmetric(horizontal: 6.safeBlockHorizontal(), vertical: 1.safeBlockVertical()),
                        onTap: () => userLocationViewModel.getCurrentLocation().then((value) => Get.to(const MapScreen(), transition: Transition.downToUp)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImageProvider(
                              imagePath: AppRepoAssets().markerImage,
                              width: 8.safeBlockHorizontal(),
                              height: 8.safeBlockHorizontal(),
                              boxFit: BoxFit.scaleDown,
                            ),
                            SizedBox(width: 2.safeBlockHorizontal()),
                            CustomText(
                              text: AppTranslations.startTracking.capitalize!,
                              textAlign: TextAlign.center,
                              fontSize: 4.fontSize(),
                              fontWeight: FontWeight.w500,
                              textColor: AppRepoColors().appFontWhiteColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
