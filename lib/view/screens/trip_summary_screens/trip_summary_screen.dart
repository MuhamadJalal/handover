import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:handover/di/injector.dart';
import 'package:handover/helper/barrel_helper.dart';
import 'package:handover/view/common_widget/barrel_common_widget.dart';
import 'package:handover/view_model/barrel_view_model.dart';

class TripSummaryWidget extends StatelessWidget {
  const TripSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<RateViewModel>(
      init: getIt<RateViewModel>(),
      builder: (deliveryViewModel) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RatingStars(
                value: deliveryViewModel.rateValue.value,
                starCount: 5,
                starSize: 12.safeBlockHorizontal(),
                maxValueVisibility: false,
                valueLabelVisibility: false,
                animationDuration: const Duration(milliseconds: 400),
                starOffColor: AppRepoColors().appWhiteColor,
                starColor: AppRepoColors().appAccentColor,
                onValueChanged: deliveryViewModel.onValueChanged,
                starBuilder: (index, color) => Icon(
                  Icons.star,
                  color: color,
                  size: 14.safeBlockHorizontal(),
                ),
              ),
              SizedBox(height: 2.safeBlockVertical()),
              LabelWidget(title: AppTranslations.pickupTime.capitalize, value: '10:00 PM'),
              LabelWidget(title: AppTranslations.deliveryTime.capitalize, value: '11:30 PM'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: 4.safeBlockHorizontal()),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: AppTranslations.total.capitalize,
                          textAlign: TextAlign.center,
                          fontSize: 4.0.fontSize(),
                          fontWeight: FontWeight.w600,
                          textColor: AppRepoColors().appFontBlackColor,
                        ),
                        SizedBox(height: 3.safeBlockVertical()),
                        CustomText(
                          text: '\$30.00',
                          textAlign: TextAlign.center,
                          fontSize: 4.0.fontSize(),
                          fontWeight: FontWeight.w800,
                          textColor: AppRepoColors().appFontBlackColor,
                        ),
                        SizedBox(height: 2.safeBlockVertical()),
                      ],
                    ),
                  ),
                  SizedBox(width: 2.safeBlockHorizontal()),
                  CustomRoundedWidgetButton(
                    height: 5.5.safeBlockVertical(),
                    width: 55.safeBlockHorizontal(),
                    borderRadius: Get.locale?.languageCode == 'en' ? AppRepoSizes().onlyLeftCircularCornerRadius : AppRepoSizes().onlyRightCircularCornerRadius,
                    backgroundColor: AppRepoColors().appWhiteColor,
                    alignment: Alignment.center,
                    onTap: Get.back,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: AppTranslations.submit.capitalize,
                            textAlign: TextAlign.center,
                            fontSize: 4.0.fontSize(),
                            fontWeight: FontWeight.w600,
                            textColor: AppRepoColors().appFontBlackColor,
                          ),
                        ),
                        SizedBox(width: 2.safeBlockHorizontal()),
                        RotatedBox(
                          quarterTurns: 90,
                          child: CustomImageProvider(
                            onTap: Get.back,
                            imagePath: AppRepoAssets().backImage,
                            boxFit: BoxFit.scaleDown,
                            height: 5.safeBlockHorizontal(),
                            width: 5.safeBlockHorizontal(),
                          ),
                        ),
                        SizedBox(width: 2.safeBlockHorizontal()),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.safeBlockVertical()),
            ],
          ));
}
